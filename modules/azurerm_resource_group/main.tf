resource "azurerm_resource_group" "rg01" {
  name     = var.rg_name
  location = var.rg_location

  tags = var.rg_tags



  lifecycle {
    # prevent_destroy = true
    #    create_before_destroy = true
    #    ignore_changes = [name, location]
  }

}
