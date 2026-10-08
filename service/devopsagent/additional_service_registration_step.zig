const OAuthAdditionalStepDetails = @import("o_auth_additional_step_details.zig").OAuthAdditionalStepDetails;

/// Additional steps required to complete service registration.
pub const AdditionalServiceRegistrationStep = union(enum) {
    /// OAuth authorization step required.
    oauth: ?OAuthAdditionalStepDetails,

    pub const json_field_names = .{
        .oauth = "oauth",
    };
};
