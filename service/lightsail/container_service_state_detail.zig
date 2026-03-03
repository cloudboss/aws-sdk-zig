const ContainerServiceStateDetailCode = @import("container_service_state_detail_code.zig").ContainerServiceStateDetailCode;

/// Describes the current state of a container service.
pub const ContainerServiceStateDetail = struct {
    /// The state code of the container service.
    ///
    /// The following state codes are possible:
    ///
    /// * The following state codes are possible if your container service is in a
    /// `DEPLOYING` or `UPDATING` state:
    ///
    /// * `CREATING_SYSTEM_RESOURCES` - The system resources for your container
    /// service are being created.
    ///
    /// * `CREATING_NETWORK_INFRASTRUCTURE` - The network infrastructure for your
    /// container service are being created.
    ///
    /// * `PROVISIONING_CERTIFICATE` - The SSL/TLS certificate for your container
    /// service is being created.
    ///
    /// * `PROVISIONING_SERVICE` - Your container service is being
    /// provisioned.
    ///
    /// * `CREATING_DEPLOYMENT` - Your deployment is being created on your
    /// container service.
    ///
    /// * `EVALUATING_HEALTH_CHECK` - The health of your deployment is being
    /// evaluated.
    ///
    /// * `ACTIVATING_DEPLOYMENT` - Your deployment is being activated.
    ///
    /// * The following state codes are possible if your container service is in a
    /// `PENDING` state:
    ///
    /// * `CERTIFICATE_LIMIT_EXCEEDED` - The SSL/TLS certificate required for
    /// your container service exceeds the maximum number of certificates allowed
    /// for your
    /// account.
    ///
    /// * `UNKNOWN_ERROR` - An error was experienced when your container service
    /// was being created.
    code: ?ContainerServiceStateDetailCode = null,

    /// A message that provides more information for the state code.
    ///
    /// The state detail is populated only when a container service is in a
    /// `PENDING`, `DEPLOYING`, or `UPDATING` state.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
