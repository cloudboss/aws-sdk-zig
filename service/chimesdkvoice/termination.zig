/// Termination settings enable SIP hosts to make outbound calls using an Amazon
/// Chime SDK Voice Connector.
pub const Termination = struct {
    /// The countries to which calls are allowed, in ISO 3166-1 alpha-2 format.
    /// Required.
    calling_regions: ?[]const []const u8 = null,

    /// The IP addresses allowed to make calls, in CIDR format.
    cidr_allowed_list: ?[]const []const u8 = null,

    /// The limit on calls per second. Max value based on account service quota.
    /// Default value of 1.
    cps_limit: ?i32 = null,

    /// The default outbound calling number.
    default_phone_number: ?[]const u8 = null,

    /// When termination is disabled, outbound calls cannot be made.
    disabled: ?bool = null,

    pub const json_field_names = .{
        .calling_regions = "CallingRegions",
        .cidr_allowed_list = "CidrAllowedList",
        .cps_limit = "CpsLimit",
        .default_phone_number = "DefaultPhoneNumber",
        .disabled = "Disabled",
    };
};
