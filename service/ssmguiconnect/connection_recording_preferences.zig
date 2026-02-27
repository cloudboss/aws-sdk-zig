const RecordingDestinations = @import("recording_destinations.zig").RecordingDestinations;

/// The set of preferences used for recording RDP connections in the requesting
/// Amazon Web Services account and Amazon Web Services Region. This includes
/// details such as which S3 bucket recordings are stored in.
pub const ConnectionRecordingPreferences = struct {
    /// The ARN of a KMS key that is used to encrypt data while it is being
    /// processed by the service. This key must exist in the same Amazon Web
    /// Services Region as the node you start an RDP connection to.
    kms_key_arn: []const u8,

    /// Determines where recordings of RDP connections are stored.
    recording_destinations: RecordingDestinations,

    pub const json_field_names = .{
        .kms_key_arn = "KMSKeyArn",
        .recording_destinations = "RecordingDestinations",
    };
};
