const SoftwareUpdateOptions = @import("software_update_options.zig").SoftwareUpdateOptions;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status of the service software options for a domain.
pub const SoftwareUpdateOptionsStatus = struct {
    /// The service software update options for a domain.
    options: ?SoftwareUpdateOptions,

    /// The status of service software update options, including creation date and
    /// last
    /// updated date.
    status: ?OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
