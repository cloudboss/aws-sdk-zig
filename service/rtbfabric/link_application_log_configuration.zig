const LinkApplicationLogSampling = @import("link_application_log_sampling.zig").LinkApplicationLogSampling;

/// Describes the configuration of a link application log.
pub const LinkApplicationLogConfiguration = struct {
    /// Describes a link application log sample.
    sampling: LinkApplicationLogSampling,

    pub const json_field_names = .{
        .sampling = "sampling",
    };
};
