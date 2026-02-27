pub const DeliveryModel = enum {
    saas_or_paas,
    byol_or_ami,
    managed_services,
    professional_services,
    resell,
    other,

    pub const json_field_names = .{
        .saas_or_paas = "SAAS_OR_PAAS",
        .byol_or_ami = "BYOL_OR_AMI",
        .managed_services = "MANAGED_SERVICES",
        .professional_services = "PROFESSIONAL_SERVICES",
        .resell = "RESELL",
        .other = "OTHER",
    };
};
