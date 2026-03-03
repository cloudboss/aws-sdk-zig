const AddThingsToThingGroupParams = @import("add_things_to_thing_group_params.zig").AddThingsToThingGroupParams;
const EnableIoTLoggingParams = @import("enable_io_t_logging_params.zig").EnableIoTLoggingParams;
const PublishFindingToSnsParams = @import("publish_finding_to_sns_params.zig").PublishFindingToSnsParams;
const ReplaceDefaultPolicyVersionParams = @import("replace_default_policy_version_params.zig").ReplaceDefaultPolicyVersionParams;
const UpdateCACertificateParams = @import("update_ca_certificate_params.zig").UpdateCACertificateParams;
const UpdateDeviceCertificateParams = @import("update_device_certificate_params.zig").UpdateDeviceCertificateParams;

/// The set of parameters for this mitigation action. You can specify only one
/// type of parameter (in other words, you can apply only one action for each
/// defined mitigation action).
pub const MitigationActionParams = struct {
    /// Parameters to define a mitigation action that moves devices associated with
    /// a certificate to one or more specified thing groups, typically for
    /// quarantine.
    add_things_to_thing_group_params: ?AddThingsToThingGroupParams = null,

    /// Parameters to define a mitigation action that enables Amazon Web Services
    /// IoT Core logging at a specified level of detail.
    enable_io_t_logging_params: ?EnableIoTLoggingParams = null,

    /// Parameters to define a mitigation action that publishes findings to Amazon
    /// Simple Notification Service (Amazon SNS. You can implement your own custom
    /// actions in response to the Amazon SNS messages.
    publish_finding_to_sns_params: ?PublishFindingToSnsParams = null,

    /// Parameters to define a mitigation action that adds a blank policy to
    /// restrict permissions.
    replace_default_policy_version_params: ?ReplaceDefaultPolicyVersionParams = null,

    /// Parameters to define a mitigation action that changes the state of the CA
    /// certificate to inactive.
    update_ca_certificate_params: ?UpdateCACertificateParams = null,

    /// Parameters to define a mitigation action that changes the state of the
    /// device certificate to inactive.
    update_device_certificate_params: ?UpdateDeviceCertificateParams = null,

    pub const json_field_names = .{
        .add_things_to_thing_group_params = "addThingsToThingGroupParams",
        .enable_io_t_logging_params = "enableIoTLoggingParams",
        .publish_finding_to_sns_params = "publishFindingToSnsParams",
        .replace_default_policy_version_params = "replaceDefaultPolicyVersionParams",
        .update_ca_certificate_params = "updateCACertificateParams",
        .update_device_certificate_params = "updateDeviceCertificateParams",
    };
};
