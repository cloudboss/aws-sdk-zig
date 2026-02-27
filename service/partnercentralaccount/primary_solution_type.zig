pub const PrimarySolutionType = enum {
    software_products,
    consulting_services,
    professional_services,
    managed_services,
    hardware_products,
    communication_services,
    value_added_resale_aws_services,
    training_services,

    pub const json_field_names = .{
        .software_products = "SOFTWARE_PRODUCTS",
        .consulting_services = "CONSULTING_SERVICES",
        .professional_services = "PROFESSIONAL_SERVICES",
        .managed_services = "MANAGED_SERVICES",
        .hardware_products = "HARDWARE_PRODUCTS",
        .communication_services = "COMMUNICATION_SERVICES",
        .value_added_resale_aws_services = "VALUE_ADDED_RESALE_AWS_SERVICES",
        .training_services = "TRAINING_SERVICES",
    };
};
