variable "name_attributes" {
  type = object({
    project     = string
    environment = string
    location    = string
    instance    = string
  })

  default = {
    project     = ""
    environment = ""
    location    = ""
    instance    = "0"
  }

  validation {
    condition     = (!var.government) || (var.name_attributes.project == "" && var.name_attributes.environment == "" && var.name_attributes.location == "" && var.name_attributes.instance == "0")
    error_message = "The variable 'name_attributes' must not be set if the variable 'government' is set to true."
  }

  validation {
    condition     = (var.government || (length(var.name_attributes.environment) > 0 && length(var.name_attributes.environment) <= 10))
    error_message = "Environment must be between 1-10 characters long"
  }

  validation {
    condition     = (var.government || (length(var.name_attributes.project) > 0 && length(var.name_attributes.project) <= 10))
    error_message = "Project name must be between 1-10 characters long."
  }

  validation {
    condition     = (var.government || contains(["canadacentral", "canadaeast"], replace(lower(var.name_attributes.location), " ", "")))
    error_message = "Location provided is not valid. Valid locations are 'Canada Central', 'Canada East'."
  }

  validation {
    condition     = (var.government || (tonumber(var.name_attributes.instance) >= 0 && tonumber(var.name_attributes.instance) < 100))
    error_message = "The variable var.name_attributes.instance must be between 0-100."
  }
}

variable "name_attributes_ssc" {
  type = object({
    department_code    = string
    csp_region         = string
    environment        = string
    instance           = string
    owner              = string
    parent_object_name = string
  })

  default = {
    department_code    = ""
    csp_region         = ""
    environment        = ""
    instance           = "0"
    owner              = ""
    parent_object_name = "ParentObjName"
  }

  description = <<EOT
    name_attributes_ssc = {
      department_code : "Two character code that uniquely identifies departments across the GC. REQUIRED."
      csp_region : "Single character code that identifies Cloud Service Provider and Region. REQUIRED."
      environment : "Single character code that identifies environment. REQUIRED."
      instance : "The instance number of the object."
      owner : "The name of the resource owner."
      parent_object_name : "The name of the parent object without the suffix (if applicable). Ex: GcPcCNR-CORE"
    }
  EOT

  validation {
    condition     = var.government || (var.name_attributes_ssc.department_code == "" && var.name_attributes_ssc.csp_region == "" && var.name_attributes_ssc.environment == "")
    error_message = "The variable 'name_attributes_ssc' must not be set if the variable 'government' is set to false."
  }

  validation {
    condition     = (!var.government || length(var.name_attributes_ssc.environment) == 1)
    error_message = "Environment must be 1 character long."
  }

  validation {
    condition     = (!var.government || length(var.name_attributes_ssc.department_code) == 2)
    error_message = "Department code must be 2 characters long."
  }

  validation {
    condition     = (!var.government || length(var.name_attributes_ssc.csp_region) == 1)
    error_message = "CSP region must be 1 character long."
  }

  validation {
    condition     = (!var.government || var.name_attributes_ssc.instance == "" || (tonumber(var.name_attributes_ssc.instance) >= 1 && tonumber(var.name_attributes_ssc.instance) < 100))
    error_message = "The variable var.name_attributes.instance must be between 1-100."
  }

  validation {
    condition     = (!var.government || var.name_attributes_ssc.owner == "" || length(var.name_attributes_ssc.owner) >= 3 && length(var.name_attributes_ssc.owner) <= 4)
    error_message = "The variable owner must be between 3-4 characters."
  }

  validation {
    condition     = (!var.government || var.name_attributes_ssc.parent_object_name == "ParentObjName" || length(var.name_attributes_ssc.parent_object_name) >= 2 && length(var.name_attributes_ssc.parent_object_name) <= 30)
    error_message = "The variable parent_object_name must be between 2-30 characters."
  }
}

variable "user_defined" {
  description = "A list of user-defined fields that describes the Azure resource."
  type        = list(string)
  default     = []

  validation {
    condition     = !var.government || length(var.user_defined) >= 1 && alltrue([for item in var.user_defined : length(item) >= 2 && length(item) <= 15])
    error_message = "Each user-defined field must be between 2-15 characters long, and the list must contain at least one item."
  }
}

variable "government" {
  type        = bool
  default     = false
  description = "Sets which naming convention to use. If true, use SSC's naming convention and set the name_attributes_ssc variable, otherwise set the name_attributes variable."
}
