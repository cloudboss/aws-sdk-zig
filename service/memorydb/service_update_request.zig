/// A request to apply a service update
pub const ServiceUpdateRequest = struct {
    /// The unique ID of the service update
    service_update_name_to_apply: ?[]const u8 = null,

    pub const json_field_names = .{
        .service_update_name_to_apply = "ServiceUpdateNameToApply",
    };
};
