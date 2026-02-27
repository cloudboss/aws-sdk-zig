const VPCDerivedInfo = @import("vpc_derived_info.zig").VPCDerivedInfo;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Status of the VPC options for the specified Elasticsearch domain.
pub const VPCDerivedInfoStatus = struct {
    /// Specifies the VPC options for the specified Elasticsearch domain.
    options: VPCDerivedInfo,

    /// Specifies the status of the VPC options for the specified Elasticsearch
    /// domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
