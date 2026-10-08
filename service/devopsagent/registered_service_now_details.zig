/// Details specific to a registered ServiceNow instance.
pub const RegisteredServiceNowDetails = struct {
    /// The ServiceNow instance url
    instance_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_url = "instanceUrl",
    };
};
