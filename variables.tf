variable "name_attributes" {
  type = object({
    department_code = string
    owner           = string
    project         = string
    environment     = string
    location        = string
    instance        = string
  })

  default = {
    department_code = ""
    owner           = ""
    project         = ""
    environment     = ""
    location        = ""
    instance        = ""
  }

  description = <<EOT
    name_attributes = {
      department_code : "Two character code that uniquely identifies departments across the GC. REQUIRED."
      owner : "The name of the resource owner. OPTIONAL."
      project" "The name of the project. REQUIRED"
      environment : "Single character code that identifies environment. REQUIRED."
      location : "Single character code that identifies Cloud Service Provider and Region. REQUIRED."
      instance : "The instance number of the object. OPTIONAL."
    }
  EOT

  validation {
    condition     = length(var.name_attributes.department_code) == 2
    error_message = "Department code must be 2 characters long."
  }
}

variable "user_defined" {
  description = "A user-defined field that describes the Azure resource."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.user_defined) >= 2 && length(var.user_defined) <= 15
    error_message = "The user-defined field must be between 2-15 characters long."
  }
}

variable "naming_convention" {
  type        = string
  default     = "oss"
  description = "Sets which naming convention to use. Accepted values: oss, gc"
  validation {
    condition     = var.naming_convention == "oss" || var.naming_convention == "gc"
    error_message = "The naming_convention field must either be 'oss' or 'gc'."
  }
}
