const EBSOptions = @import("ebs_options.zig").EBSOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of the EBS options for the specified OpenSearch Service domain.
pub const EBSOptionsStatus = struct {
    /// The configured EBS options for the specified domain.
    options: EBSOptions,

    /// The status of the EBS options for the specified domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
