pub const ReceiverResponsibility = enum {
    distributor,
    reseller,
    hardware_partner,
    managed_service_provider,
    software_partner,
    services_partner,
    training_partner,
    co_sell_facilitator,
    facilitator,

    pub const json_field_names = .{
        .distributor = "DISTRIBUTOR",
        .reseller = "RESELLER",
        .hardware_partner = "HARDWARE_PARTNER",
        .managed_service_provider = "MANAGED_SERVICE_PROVIDER",
        .software_partner = "SOFTWARE_PARTNER",
        .services_partner = "SERVICES_PARTNER",
        .training_partner = "TRAINING_PARTNER",
        .co_sell_facilitator = "CO_SELL_FACILITATOR",
        .facilitator = "FACILITATOR",
    };
};
