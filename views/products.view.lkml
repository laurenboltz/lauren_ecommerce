view: products {
  sql_table_name: demo_db.products ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql:
   CASE
  WHEN ${TABLE}.brand = "Calvin Klein" then "Calvin Klein"
  WHEN ${TABLE}.brand = "O'Neill" then "O'Neill"
  ELSE "Other"
  End;;
  }

  dimension: brand_logo {
    type: string
    sql: ${TABLE}.brand ;;
    ### each if statement should be evaluating the field, then spitting out an image
    ### replace customer here with the name of your field
    ### replace the values with the values from the database column
    ### insert elsif statements for more images
    html:
     {% if brand._value == "O'Neill" %}
     <img src="https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/0024/5906/brand.gif?itok=1S4DL3m9" />
     {% elsif brand._value == "Calvin Klein" %}
     <img src="https://logos-download.com/wp-content/uploads/2016/02/CK_logo-700x685.png" height="400" width="400">
    {% else %}
     <img src="https://icon-library.net/images/no-image-available-icon/no-image-available-icon-6.jpg">
    {% endif %};;
  }


  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
}
