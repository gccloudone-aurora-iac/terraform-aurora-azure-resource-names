variable "name_attributes" {
  type = object({
    department_code = string
    csp_region      = string
    environment     = string
    instance        = string
    owner           = string
    project         = string
  })

  default = {
    department_code = ""
    csp_region      = ""
    environment     = ""
    instance        = ""
    owner           = ""
    project         = ""
  }

  description = <<EOT
    name_attributes = {
      department_code : "Two character code that uniquely identifies departments across the GC. REQUIRED."
      csp_region : "Single character code that identifies Clouser_defined_string Service Provider and Region. REQUIRED."
      environment : "Single character code that identifies environment. REQUIRED."
      instance : "The instance number of the object. OPTIONAL."
      owner : "The name of the resource owner. OPTIONAL."
      project" "The name of the project. REQUIRED"
    }
  EOT

  validation {
    condition     = length(var.name_attributes.environment) == 1
    error_message = "Environment must be 1 character long."
  }

  validation {
    condition     = length(var.name_attributes.department_code) == 2
    error_message = "Department code must be 2 characters long."
  }

  validation {
    condition     = length(var.name_attributes.csp_region) == 1
    error_message = "CSP region must be 1 character long."
  }

  validation {
    condition     = var.name_attributes.instance == "" || (tonumber(var.name_attributes.instance) >= 0 && tonumber(var.name_attributes.instance) < 100)
    error_message = "The variable var.name_attributes.instance must be between 1-100."
  }

  validation {
    condition     = (var.name_attributes.owner == "" || length(var.name_attributes.owner) >= 3 && length(var.name_attributes.owner) <= 4)
    error_message = "The variable owner must be between 3-4 characters."
  }

  validation {
    condition     = length(var.name_attributes.project) > 0 && length(var.name_attributes.project) <= 10
    error_message = "The project field must be between 1-10 characters long."
  }
}

variable "user_defined" {
  description = "A list of user-defined fields that describes the Azure resource."
  type        = list(string)
  default     = []

  validation {
    condition     = var.naming_convention == "stc" || (var.naming_convention == "ssc" && length(var.user_defined) >= 1 && alltrue([for user_defined_string in var.user_defined : length(user_defined_string) >= 2 && length(user_defined_string) <= 15]))
    error_message = "Each user-defined field must be between 2-15 characters long. REQUIRED if using SSC naming convention. Otherwise OPTIONAL"
  }
}

variable "parent_object_names" {
  description = "The names of the parent objects without the suffix (if applicable). Ex: GcPcCNR-CORE. You should define this variable if the parent object name is not determined from this module. Optional."
  type        = list(string)
  default     = []

  validation {
    condition     = (var.parent_object_names == [] || length(var.parent_object_names) >= 0 && alltrue([for name in var.parent_object_names : length(name) >= 2 && length(name) <= 15]))
    error_message = "Each parent_object_name must be between 2-30 characters."
  }
}

variable "naming_convention" {
  type        = string
  default     = "stc"
  description = "Sets which naming convention to use. Accepted values: stc, ssc"
  validation {
    condition     = var.naming_convention == "ssc" || var.naming_convention == "stc"
    error_message = "The accepted values for the government variable are: stc, ssc."
  }
}
