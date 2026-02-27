const EBSOptions = @import("ebs_options.zig").EBSOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// Status of the EBS options for the specified Elasticsearch domain.
pub const EBSOptionsStatus = struct {
    /// Specifies the EBS options for the specified Elasticsearch domain.
    options: EBSOptions,

    /// Specifies the status of the EBS options for the specified Elasticsearch
    /// domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
