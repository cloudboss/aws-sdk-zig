pub const TemplateType = enum {
    fleet_provisioning,
    jitp,

    pub const json_field_names = .{
        .fleet_provisioning = "FLEET_PROVISIONING",
        .jitp = "JITP",
    };
};
