const AdditionalConstraintsElement = @import("additional_constraints_element.zig").AdditionalConstraintsElement;

/// The password policy configuration for the backend to your Amplify project.
pub const CreateBackendAuthPasswordPolicyConfig = struct {
    /// Additional constraints for the password used to access the backend of your
    /// Amplify project.
    additional_constraints: ?[]const AdditionalConstraintsElement = null,

    /// The minimum length of the password used to access the backend of your
    /// Amplify project.
    minimum_length: f64,

    pub const json_field_names = .{
        .additional_constraints = "AdditionalConstraints",
        .minimum_length = "MinimumLength",
    };
};
