const aws = @import("aws");

const LogPublishingOption = @import("log_publishing_option.zig").LogPublishingOption;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The configured log publishing options for the domain and their current
/// status.
pub const LogPublishingOptionsStatus = struct {
    /// The log publishing options configured for the domain.
    options: ?[]const aws.map.MapEntry(LogPublishingOption) = null,

    /// The status of the log publishing options for the domain.
    status: ?OptionStatus = null,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
