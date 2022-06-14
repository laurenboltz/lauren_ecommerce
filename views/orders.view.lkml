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
      description: "The current status of an existing order."
    }

    dimension: user_id {
      type: number
      # hidden: yes
      sql: ${TABLE}.user_id ;;
    }
    
    dimension: bad_state {
    type: string
    sql: 1=1 ;;
    }

    measure: count {
      type: count
      drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
    }
  }
