const MonthlyTransfer = @import("monthly_transfer.zig").MonthlyTransfer;
const InstancePortInfo = @import("instance_port_info.zig").InstancePortInfo;

/// Describes monthly data transfer rates and port information for an instance.
pub const InstanceNetworking = struct {
    /// The amount of data in GB allocated for monthly data transfers.
    monthly_transfer: ?MonthlyTransfer = null,

    /// An array of key-value pairs containing information about the ports on the
    /// instance.
    ports: ?[]const InstancePortInfo = null,

    pub const json_field_names = .{
        .monthly_transfer = "monthlyTransfer",
        .ports = "ports",
    };
};
