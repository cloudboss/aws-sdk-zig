const AdditionalConstraintsElement = @import("additional_constraints_element.zig").AdditionalConstraintsElement;

/// Describes the password policy for your Amazon Cognito user pool configured
/// as a part of your Amplify project.
pub const UpdateBackendAuthPasswordPolicyConfig = struct {
    /// Describes additional constraints on password requirements to sign in to the
    /// auth resource, configured as a part of your Amplify project.
    additional_constraints: ?[]const AdditionalConstraintsElement,

    /// Describes the minimum length of the password required to sign in to the auth
    /// resource, configured as a part of your Amplify project.
    minimum_length: ?f64,

    pub const json_field_names = .{
        .additional_constraints = "AdditionalConstraints",
        .minimum_length = "MinimumLength",
    };
};
