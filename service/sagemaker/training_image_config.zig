const TrainingRepositoryAccessMode = @import("training_repository_access_mode.zig").TrainingRepositoryAccessMode;
const TrainingRepositoryAuthConfig = @import("training_repository_auth_config.zig").TrainingRepositoryAuthConfig;

/// The configuration to use an image from a private Docker registry for a
/// training job.
pub const TrainingImageConfig = struct {
    /// The method that your training job will use to gain access to the images in
    /// your private Docker registry. For access to an image in a private Docker
    /// registry, set to `Vpc`.
    training_repository_access_mode: TrainingRepositoryAccessMode,

    /// An object containing authentication information for a private Docker
    /// registry containing your training images.
    training_repository_auth_config: ?TrainingRepositoryAuthConfig,

    pub const json_field_names = .{
        .training_repository_access_mode = "TrainingRepositoryAccessMode",
        .training_repository_auth_config = "TrainingRepositoryAuthConfig",
    };
};
