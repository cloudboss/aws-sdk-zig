const SlurmRestMode = @import("slurm_rest_mode.zig").SlurmRestMode;

/// The Slurm REST API configuration includes settings for enabling and
/// configuring the Slurm REST API.
pub const UpdateSlurmRestRequest = struct {
    /// The default value for `mode` is `NONE`. A value of `STANDARD` means the
    /// Slurm REST API is enabled.
    mode: ?SlurmRestMode,

    pub const json_field_names = .{
        .mode = "mode",
    };
};
