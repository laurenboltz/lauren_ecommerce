view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    link: {
      label: "Contact Warehouse Support"
      url: "mailto:warehouse@brettcase.com"
    }
  }

  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: "Break down by Day"
      value: "day"
    }
    allowed_value: {
      label: "Break down by Month"
      value: "month"
    }
    description: "Choose the granularity of time by which to group results."
  }

  # dimension: looker_image {
  #   type: string
  #   sql: 1=1;;
  #   html: <img src="https://looker.com/assets/img/images/logos/looker_black.svg" height="25" width="auto"/> ;;
  # }


  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: date {
    sql:
    {% if date_granularity._parameter_value == 'day' %}
      ${created_date}
    {% elsif date_granularity._parameter_value == 'month' %}
      ${created_month}
    {% else %}
      ${created_date}
    {% endif %};;
#     html:
#     {% if date_granularity._parameter_value == 'day' %}
#     <font color="darkgreen">{{ rendered_value }}</font>
#     {% elsif date_granularity._parameter_value == 'month' %}
#     <font color="darkred">{{ rendered_value }}</font>
#     {% else %}
#       ${created_date}
#     {% endif %};;
    }

    dimension: status {
      type: string
      sql: ${TABLE}.status ;;
      link: {
        label: "Contact Warehouse Support"
        url: "mailto:warehouse@brettcase.com"
      }
      # html:
      #   {% if value == 'complete' %}
      #     <p><img src="https://findicons.com/files/icons/573/must_have/48/check.png" height=20 width=20>{{ rendered_value }}</p>
      #   {% elsif value == 'pending' %}
      #     <p><img src="https://findicons.com/files/icons/1681/siena/128/clock_blue.png" height=20 width=20>{{ rendered_value }}</p>
      #   {% else %}
      #     <p><img src="https://findicons.com/files/icons/719/crystal_clear_actions/64/cancel.png" height=20 width=20>{{ rendered_value }}</p>
      #   {% endif %}
      # ;;
      description: "The current status of an existing order."
    }

    dimension: user_id {
      type: number
      # hidden: yes
      sql: ${TABLE}.user_id ;;
    }

    measure: count {
      type: count
      drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
    }
  # measure: returned_count { # Explore Top 20 for More Powerful Data Drilling
  #   type: count_distinct
  #   sql: ${id} ;;
  #   link: {
  #     label: "Explore Top 20 Results"
  #     url: "{{ link }}&limit=20"
  #   }
  # }

  # measure: returned_count { #Explore Top 20 by Sale Price for More Powerful Data Drilling
  #   type: count_distinct
  #   sql: ${id} ;;
  #   link: {
  #     label: "Explore Top 20 Results by Sale Price"
  #     url: "{{ link }}&sorts=order_items.sale_price+desc&limit=20"
  #   }
  # }

  # measure: order_count { # Explore Total Sale Price by Month for each age tier for More Powerful Data Drilling
  #   type: count_distinct
  #   link: {
  #     label: "Total Sale Price by Month for Each Age Tier"
  #     url: "{{link}}&pivots=users.age_tier"
  #   }
  #   sql: ${id} ;;
  # }

  }
