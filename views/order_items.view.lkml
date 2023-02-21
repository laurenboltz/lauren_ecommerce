view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  parameter: item_to_add_up {
    type: unquoted
    allowed_value: {
      label: "Total Sale Price"
      value: "sale_price"
    }
    allowed_value: {
      label: "Total Cost"
      value: "cost"
    }
    allowed_value: {
      label: "Total Profit"
      value: "profit"
    }
    description: "Use this filter with the Dynamic Sum measure to choose the field to total."
  }

  dimension: profit {
    type: number
    sql: ${sale_price} - ${inventory_items.cost} ;;
    description: "The difference between an item's sale price and an item's cost."
  }

  dimension: cost {
    type: number
    sql: ${inventory_items.cost};;
    description: "The cost of an item."
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
    description: "The price at which an item is set to sell."
  }

  dimension: gross_margin {
    type: number
    sql: ${profit} ;;
    description: "The sale price minus the cost of an item."
  }

  measure: dynamic_sum {
    type: sum
    sql: ${TABLE}.{% parameter item_to_add_up %} ;;
    value_format_name: "usd"
    label_from_parameter: item_to_add_up
    description: "Use this field in conjunctionwith the Item to Add Up filter to select the field to total."
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, orders.id]
  }

  measure: total_cost {
    type: sum
    sql: ${cost} ;;
    value_format_name: "usd"
  }

  measure: total_gross_margin {
    type: sum
    value_format_name: "usd"
    sql: ${gross_margin} ;;
    html: {{ rendered_value }} | {{percent_of_gross_margin._rendered_value }} of total ;;

  }

  measure: percent_of_gross_margin {
    type: number
    sql: ((${total_cost}-${total_gross_margin})/${total_gross_margin}) ;;
    value_format_name: percent_2
  }
}
