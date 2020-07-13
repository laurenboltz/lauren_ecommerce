view: order_items {
  sql_table_name: public.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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
  }

  dimension: profit {
    type: number
    sql: ${sale_price} - ${inventory_items.cost} ;;
  }
  dimension: cost {
    type: number
    sql: ${inventory_items.cost};;
  }

  measure: dynamic_sum {
    type: sum
    sql: ${% parameter item_to_add_up %} ;;
    value_format_name: "usd"
    label_from_parameter: item_to_add_up
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
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



  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
