const VerificationScriptEnvVar = @import("verification_script_env_var.zig").VerificationScriptEnvVar;

/// Contains metadata for a verification script that can be used to reproduce a
/// security finding.
pub const VerificationScript = struct {
    /// The list of environment variables required to run the verification script.
    env_vars: ?[]const VerificationScriptEnvVar = null,

    /// Instructions for running the verification script, including prerequisites
    /// and how to interpret results.
    instructions: ?[]const u8 = null,

    /// The type of script. Valid values are python and bash.
    script_type: ?[]const u8 = null,

    /// URL to download the verification script.
    script_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .env_vars = "envVars",
        .instructions = "instructions",
        .script_type = "scriptType",
        .script_url = "scriptUrl",
    };
};
