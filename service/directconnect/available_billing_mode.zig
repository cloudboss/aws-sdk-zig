const BillingMode = @import("billing_mode.zig").BillingMode;

/// Information about a billing mode available at an Direct Connect location.
pub const AvailableBillingMode = struct {
    /// The port speeds available for the billing mode.
    available_port_speeds: ?[]const []const u8 = null,

    /// The billing mode.
    billing_mode: ?BillingMode = null,

    /// The Amazon Web Services Regions included with the billing mode.
    included_regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .available_port_speeds = "availablePortSpeeds",
        .billing_mode = "billingMode",
        .included_regions = "includedRegions",
    };
};
