const DNISEmergencyCallingConfiguration = @import("dnis_emergency_calling_configuration.zig").DNISEmergencyCallingConfiguration;

/// The emergency calling configuration details associated with an Amazon Chime
/// SDK
/// Voice Connector.
pub const EmergencyCallingConfiguration = struct {
    /// The Dialed Number Identification Service (DNIS) emergency calling
    /// configuration
    /// details.
    dnis: ?[]const DNISEmergencyCallingConfiguration = null,

    pub const json_field_names = .{
        .dnis = "DNIS",
    };
};
