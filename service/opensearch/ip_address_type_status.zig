const IPAddressType = @import("ip_address_type.zig").IPAddressType;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The IP address type status for the domain.
pub const IPAddressTypeStatus = struct {
    /// The IP address options for the domain.
    options: IPAddressType,

    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
