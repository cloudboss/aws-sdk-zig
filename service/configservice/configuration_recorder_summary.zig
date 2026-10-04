const Provider = @import("provider.zig").Provider;
const RecordingScope = @import("recording_scope.zig").RecordingScope;

/// A summary of a configuration recorder, including the `arn`, `name`,
/// `servicePrincipal`, `recordingScope`, and `provider`.
pub const ConfigurationRecorderSummary = struct {
    /// The Amazon Resource Name (ARN) of the configuration recorder.
    arn: []const u8,

    /// The name of the configuration recorder.
    name: []const u8,

    /// For service-linked configuration recorders that record resources from a
    /// third-party cloud service provider, indicates the cloud service provider.
    /// Currently, `AZURE` is supported.
    provider: ?Provider = null,

    /// Indicates whether the
    /// [ConfigurationItems](https://docs.aws.amazon.com/config/latest/APIReference/API_ConfigurationItem.html) in scope for the configuration recorder are recorded for free (`INTERNAL`) or if you are charged a service fee for recording (`PAID`).
    recording_scope: RecordingScope,

    /// For service-linked configuration recorders, indicates which Amazon Web
    /// Services service the configuration recorder is linked to.
    service_principal: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .provider = "provider",
        .recording_scope = "recordingScope",
        .service_principal = "servicePrincipal",
    };
};
