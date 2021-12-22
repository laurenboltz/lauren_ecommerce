view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    link: {
      label: "City Metrics Explore"
      url: "https://master.dev.looker.com/explore/lauren_ecommerce_docs/order_items?fields=users.city,orders.count,users.count&f[users.city]={{ value }}&sorts=orders.count+desc&limit=500"
    }
    link: {
      label: "City Dashboard"
      url: "https://master.dev.looker.com/dashboards-next/4145?City={{ _filters['users.city'] | url_encode }}"
    }
  }

  dimension: age_tier {
    type: tier
    tiers: [0, 10, 20, 30, 40, 50, 60, 70, 80]
    style: integer
    sql: ${age} ;;
    description: "This field is for grouping measures to analyze activity and trends by age group."
  }


  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    description: "The country in which a user resides."
  }

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
    description: "The date on which a user created an account."
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    description: "Email address associated with a user account."
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    link: {
      label: "Google"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}
