const ServerlessSasl = @import("serverless_sasl.zig").ServerlessSasl;

/// Includes all client authentication information.
pub const ServerlessClientAuthentication = struct {
    /// Details for ClientAuthentication using SASL.
    sasl: ?ServerlessSasl,

    pub const json_field_names = .{
        .sasl = "Sasl",
    };
};
