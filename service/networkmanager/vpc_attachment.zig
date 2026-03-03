const Attachment = @import("attachment.zig").Attachment;
const VpcOptions = @import("vpc_options.zig").VpcOptions;

/// Describes a VPC attachment.
pub const VpcAttachment = struct {
    /// Provides details about the VPC attachment.
    attachment: ?Attachment = null,

    /// Provides details about the VPC attachment.
    options: ?VpcOptions = null,

    /// The subnet ARNs.
    subnet_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .attachment = "Attachment",
        .options = "Options",
        .subnet_arns = "SubnetArns",
    };
};
