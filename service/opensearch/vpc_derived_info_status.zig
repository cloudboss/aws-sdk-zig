const VPCDerivedInfo = @import("vpc_derived_info.zig").VPCDerivedInfo;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Status of the VPC options for a specified domain.
pub const VPCDerivedInfoStatus = struct {
    /// The VPC options for the specified domain.
    options: VPCDerivedInfo,

    /// The status of the VPC options for the specified domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
