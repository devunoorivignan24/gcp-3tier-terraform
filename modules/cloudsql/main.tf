resource "google_sql_database_instance" "db" {
  name             = var.db_name
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.db.name
}

resource "google_sql_user" "db_user" {
  name     = var.db_user
  password = var.db_password
  instance = google_sql_database_instance.db.name
}

output "connection_name" {
  value = google_sql_database_instance.db.connection_name
}
