const InitializationType = @import("initialization_type.zig").InitializationType;

/// Information about the volume initialization. For more information, see
/// [Initialize Amazon EBS
/// volumes](https://docs.aws.amazon.com/ebs/latest/userguide/initalize-volume.html).
pub const InitializationStatusDetails = struct {
    /// The estimated remaining time, in seconds, for volume initialization to
    /// complete. Returns
    /// `0` when volume initialization has completed.
    ///
    /// Only available for volumes created with Amazon EBS Provisioned Rate for
    /// Volume Initialization.
    estimated_time_to_complete_in_seconds: ?i64 = null,

    /// The method used for volume initialization. Possible values include:
    ///
    /// * `default` - Volume initialized using the default volume initialization
    /// rate or fast snapshot restore.
    ///
    /// * `provisioned-rate` - Volume initialized using an Amazon EBS Provisioned
    /// Rate for Volume Initialization.
    ///
    /// * `volume-copy` - Volume copy initialized at the rate for volume copies.
    initialization_type: ?InitializationType = null,

    /// The current volume initialization progress as a percentage (0-100). Returns
    /// `100`
    /// when volume initialization has completed.
    progress: ?i64 = null,
};
