const aws = @import("aws");
const std = @import("std");

const associate_service_role_to_account = @import("associate_service_role_to_account.zig");
const batch_associate_client_device_with_core_device = @import("batch_associate_client_device_with_core_device.zig");
const batch_disassociate_client_device_from_core_device = @import("batch_disassociate_client_device_from_core_device.zig");
const cancel_deployment = @import("cancel_deployment.zig");
const create_component_version = @import("create_component_version.zig");
const create_deployment = @import("create_deployment.zig");
const delete_component = @import("delete_component.zig");
const delete_core_device = @import("delete_core_device.zig");
const delete_deployment = @import("delete_deployment.zig");
const describe_component = @import("describe_component.zig");
const disassociate_service_role_from_account = @import("disassociate_service_role_from_account.zig");
const get_component = @import("get_component.zig");
const get_component_version_artifact = @import("get_component_version_artifact.zig");
const get_connectivity_info = @import("get_connectivity_info.zig");
const get_core_device = @import("get_core_device.zig");
const get_deployment = @import("get_deployment.zig");
const get_service_role_for_account = @import("get_service_role_for_account.zig");
const list_client_devices_associated_with_core_device = @import("list_client_devices_associated_with_core_device.zig");
const list_component_versions = @import("list_component_versions.zig");
const list_components = @import("list_components.zig");
const list_core_devices = @import("list_core_devices.zig");
const list_deployments = @import("list_deployments.zig");
const list_effective_deployments = @import("list_effective_deployments.zig");
const list_installed_components = @import("list_installed_components.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const resolve_component_candidates = @import("resolve_component_candidates.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_connectivity_info = @import("update_connectivity_info.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "GreengrassV2";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Associates a Greengrass service role with IoT Greengrass for your Amazon Web
    /// Services account in this Amazon Web Services Region. IoT Greengrass
    /// uses this role to verify the identity of client devices and manage core
    /// device connectivity
    /// information. The role must include the
    /// [AWSGreengrassResourceAccessRolePolicy](https://console.aws.amazon.com/iam/home#/policies/arn:awsiam::aws:policy/service-role/AWSGreengrassResourceAccessRolePolicy) managed policy or a custom policy that
    /// defines equivalent permissions for the IoT Greengrass features that you use.
    /// For more information, see
    /// [Greengrass service
    /// role](https://docs.aws.amazon.com/greengrass/v2/developerguide/greengrass-service-role.html) in the *IoT Greengrass Version 2 Developer Guide*.
    pub fn associateServiceRoleToAccount(self: *Self, allocator: std.mem.Allocator, input: associate_service_role_to_account.AssociateServiceRoleToAccountInput, options: associate_service_role_to_account.Options) !associate_service_role_to_account.AssociateServiceRoleToAccountOutput {
        return associate_service_role_to_account.execute(self, allocator, input, options);
    }

    /// Associates a list of client devices with a core device. Use this API
    /// operation to specify
    /// which client devices can discover a core device through cloud discovery.
    /// With cloud discovery,
    /// client devices connect to IoT Greengrass to retrieve associated core
    /// devices' connectivity information
    /// and certificates. For more information, see [Configure cloud
    /// discovery](https://docs.aws.amazon.com/greengrass/v2/developerguide/configure-cloud-discovery.html) in the *IoT Greengrass V2 Developer Guide*.
    ///
    /// Client devices are local IoT devices that connect to and communicate with an
    /// IoT Greengrass core
    /// device over MQTT. You can connect client devices to a core device to sync
    /// MQTT messages and
    /// data to Amazon Web Services IoT Core and interact with client devices in
    /// Greengrass components. For more information,
    /// see [Interact with
    /// local IoT
    /// devices](https://docs.aws.amazon.com/greengrass/v2/developerguide/interact-with-local-iot-devices.html) in the *IoT Greengrass V2 Developer Guide*.
    pub fn batchAssociateClientDeviceWithCoreDevice(self: *Self, allocator: std.mem.Allocator, input: batch_associate_client_device_with_core_device.BatchAssociateClientDeviceWithCoreDeviceInput, options: batch_associate_client_device_with_core_device.Options) !batch_associate_client_device_with_core_device.BatchAssociateClientDeviceWithCoreDeviceOutput {
        return batch_associate_client_device_with_core_device.execute(self, allocator, input, options);
    }

    /// Disassociates a list of client devices from a core device. After you
    /// disassociate a client
    /// device from a core device, the client device won't be able to use cloud
    /// discovery to retrieve
    /// the core device's connectivity information and certificates.
    pub fn batchDisassociateClientDeviceFromCoreDevice(self: *Self, allocator: std.mem.Allocator, input: batch_disassociate_client_device_from_core_device.BatchDisassociateClientDeviceFromCoreDeviceInput, options: batch_disassociate_client_device_from_core_device.Options) !batch_disassociate_client_device_from_core_device.BatchDisassociateClientDeviceFromCoreDeviceOutput {
        return batch_disassociate_client_device_from_core_device.execute(self, allocator, input, options);
    }

    /// Cancels a deployment. This operation cancels the deployment for devices that
    /// haven't yet
    /// received it. If a device already received the deployment, this operation
    /// doesn't change
    /// anything for that device.
    pub fn cancelDeployment(self: *Self, allocator: std.mem.Allocator, input: cancel_deployment.CancelDeploymentInput, options: cancel_deployment.Options) !cancel_deployment.CancelDeploymentOutput {
        return cancel_deployment.execute(self, allocator, input, options);
    }

    /// Creates a component. Components are software that run on Greengrass core
    /// devices. After you
    /// develop and test a component on your core device, you can use this operation
    /// to upload your
    /// component to IoT Greengrass. Then, you can deploy the component to other
    /// core devices.
    ///
    /// You can use this operation to do the following:
    ///
    /// * **Create components from recipes**
    ///
    /// Create a component from a recipe, which is a file that defines the
    /// component's
    /// metadata, parameters, dependencies, lifecycle, artifacts, and platform
    /// capability. For
    /// more information, see [IoT Greengrass component recipe
    /// reference](https://docs.aws.amazon.com/greengrass/v2/developerguide/component-recipe-reference.html) in the *IoT Greengrass V2 Developer Guide*.
    ///
    /// To create a component from a recipe, specify `inlineRecipe` when you call
    /// this operation.
    ///
    /// * **Create components from Lambda functions**
    ///
    /// Create a component from an Lambda function that runs on IoT Greengrass. This
    /// creates a recipe
    /// and artifacts from the Lambda function's deployment package. You can use
    /// this operation to
    /// migrate Lambda functions from IoT Greengrass V1 to IoT Greengrass V2.
    ///
    /// This function accepts Lambda functions in all supported versions of Python,
    /// Node.js,
    /// and Java runtimes. IoT Greengrass doesn't apply any additional restrictions
    /// on deprecated Lambda
    /// runtime versions.
    ///
    /// To create a component from a Lambda function, specify `lambdaFunction` when
    /// you call this operation.
    ///
    /// IoT Greengrass currently supports Lambda functions on only Linux core
    /// devices.
    pub fn createComponentVersion(self: *Self, allocator: std.mem.Allocator, input: create_component_version.CreateComponentVersionInput, options: create_component_version.Options) !create_component_version.CreateComponentVersionOutput {
        return create_component_version.execute(self, allocator, input, options);
    }

    /// Creates a continuous deployment for a target, which is a Greengrass core
    /// device or group of core
    /// devices. When you add a new core device to a group of core devices that has
    /// a deployment, IoT Greengrass
    /// deploys that group's deployment to the new device.
    ///
    /// You can define one deployment for each target. When you create a new
    /// deployment for a
    /// target that has an existing deployment, you replace the previous deployment.
    /// IoT Greengrass applies the
    /// new deployment to the target devices.
    ///
    /// Every deployment has a revision number that indicates how many deployment
    /// revisions you
    /// define for a target. Use this operation to create a new revision of an
    /// existing
    /// deployment.
    ///
    /// For more information, see the [Create
    /// deployments](https://docs.aws.amazon.com/greengrass/v2/developerguide/create-deployments.html) in the
    /// *IoT Greengrass V2 Developer Guide*.
    pub fn createDeployment(self: *Self, allocator: std.mem.Allocator, input: create_deployment.CreateDeploymentInput, options: create_deployment.Options) !create_deployment.CreateDeploymentOutput {
        return create_deployment.execute(self, allocator, input, options);
    }

    /// Deletes a version of a component from IoT Greengrass.
    ///
    /// This operation deletes the component's recipe and artifacts. As a result,
    /// deployments
    /// that refer to this component version will fail. If you have deployments that
    /// use this
    /// component version, you can remove the component from the deployment or
    /// update the deployment
    /// to use a valid version.
    pub fn deleteComponent(self: *Self, allocator: std.mem.Allocator, input: delete_component.DeleteComponentInput, options: delete_component.Options) !delete_component.DeleteComponentOutput {
        return delete_component.execute(self, allocator, input, options);
    }

    /// Deletes a Greengrass core device, which is an IoT thing. This operation
    /// removes the core
    /// device from the list of core devices. This operation doesn't delete the IoT
    /// thing. For more
    /// information about how to delete the IoT thing, see
    /// [DeleteThing](https://docs.aws.amazon.com/iot/latest/apireference/API_DeleteThing.html) in the
    /// *IoT API Reference*.
    pub fn deleteCoreDevice(self: *Self, allocator: std.mem.Allocator, input: delete_core_device.DeleteCoreDeviceInput, options: delete_core_device.Options) !delete_core_device.DeleteCoreDeviceOutput {
        return delete_core_device.execute(self, allocator, input, options);
    }

    /// Deletes a deployment. To delete an active deployment, you must first cancel
    /// it. For more
    /// information, see
    /// [CancelDeployment](https://docs.aws.amazon.com/iot/latest/apireference/API_CancelDeployment.html).
    ///
    /// Deleting a deployment doesn't affect core devices that run that deployment,
    /// because core
    /// devices store the deployment's configuration on the device. Additionally,
    /// core devices can
    /// roll back to a previous deployment that has been deleted.
    pub fn deleteDeployment(self: *Self, allocator: std.mem.Allocator, input: delete_deployment.DeleteDeploymentInput, options: delete_deployment.Options) !delete_deployment.DeleteDeploymentOutput {
        return delete_deployment.execute(self, allocator, input, options);
    }

    /// Retrieves metadata for a version of a component.
    pub fn describeComponent(self: *Self, allocator: std.mem.Allocator, input: describe_component.DescribeComponentInput, options: describe_component.Options) !describe_component.DescribeComponentOutput {
        return describe_component.execute(self, allocator, input, options);
    }

    /// Disassociates the Greengrass service role from IoT Greengrass for your
    /// Amazon Web Services account in this Amazon Web Services Region.
    /// Without a service role, IoT Greengrass can't verify the identity of client
    /// devices or manage core device
    /// connectivity information. For more information, see [Greengrass service
    /// role](https://docs.aws.amazon.com/greengrass/v2/developerguide/greengrass-service-role.html) in
    /// the *IoT Greengrass Version 2 Developer Guide*.
    pub fn disassociateServiceRoleFromAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_service_role_from_account.DisassociateServiceRoleFromAccountInput, options: disassociate_service_role_from_account.Options) !disassociate_service_role_from_account.DisassociateServiceRoleFromAccountOutput {
        return disassociate_service_role_from_account.execute(self, allocator, input, options);
    }

    /// Gets the recipe for a version of a component.
    pub fn getComponent(self: *Self, allocator: std.mem.Allocator, input: get_component.GetComponentInput, options: get_component.Options) !get_component.GetComponentOutput {
        return get_component.execute(self, allocator, input, options);
    }

    /// Gets the pre-signed URL to download a public or a Lambda component artifact.
    /// Core devices
    /// call this operation to identify the URL that they can use to download an
    /// artifact to
    /// install.
    pub fn getComponentVersionArtifact(self: *Self, allocator: std.mem.Allocator, input: get_component_version_artifact.GetComponentVersionArtifactInput, options: get_component_version_artifact.Options) !get_component_version_artifact.GetComponentVersionArtifactOutput {
        return get_component_version_artifact.execute(self, allocator, input, options);
    }

    /// Retrieves connectivity information for a Greengrass core device.
    ///
    /// Connectivity information includes endpoints and ports where client devices
    /// can connect to an MQTT broker on the core device. When a client device
    /// calls the [IoT Greengrass discovery
    /// API](https://docs.aws.amazon.com/greengrass/v2/developerguide/greengrass-discover-api.html),
    /// IoT Greengrass returns connectivity information for all of the core devices
    /// where the client device can
    /// connect. For more information, see [Connect client devices to
    /// core
    /// devices](https://docs.aws.amazon.com/greengrass/v2/developerguide/connect-client-devices.html) in the *IoT Greengrass Version 2 Developer Guide*.
    pub fn getConnectivityInfo(self: *Self, allocator: std.mem.Allocator, input: get_connectivity_info.GetConnectivityInfoInput, options: get_connectivity_info.Options) !get_connectivity_info.GetConnectivityInfoOutput {
        return get_connectivity_info.execute(self, allocator, input, options);
    }

    /// Retrieves metadata for a Greengrass core device.
    ///
    /// IoT Greengrass relies on individual devices to send status updates to the
    /// Amazon Web Services Cloud. If the
    /// IoT Greengrass Core software isn't running on the device, or if device isn't
    /// connected to the Amazon Web Services Cloud,
    /// then the reported status of that device might not reflect its current
    /// status. The status
    /// timestamp indicates when the device status was last updated.
    ///
    /// Core devices send status updates at the following times:
    ///
    /// * When the IoT Greengrass Core software starts
    ///
    /// * When the core device receives a deployment from the Amazon Web Services
    ///   Cloud
    ///
    /// * When the status of any component on the core device becomes
    /// `BROKEN`
    ///
    /// * At a [regular interval that you can
    ///   configure](https://docs.aws.amazon.com/greengrass/v2/developerguide/greengrass-nucleus-component.html#greengrass-nucleus-component-configuration-fss), which defaults to 24 hours
    ///
    /// * For IoT Greengrass Core v2.7.0, the core device sends status updates upon
    ///   local deployment and
    /// cloud deployment
    pub fn getCoreDevice(self: *Self, allocator: std.mem.Allocator, input: get_core_device.GetCoreDeviceInput, options: get_core_device.Options) !get_core_device.GetCoreDeviceOutput {
        return get_core_device.execute(self, allocator, input, options);
    }

    /// Gets a deployment. Deployments define the components that run on Greengrass
    /// core devices.
    pub fn getDeployment(self: *Self, allocator: std.mem.Allocator, input: get_deployment.GetDeploymentInput, options: get_deployment.Options) !get_deployment.GetDeploymentOutput {
        return get_deployment.execute(self, allocator, input, options);
    }

    /// Gets the service role associated with IoT Greengrass for your Amazon Web
    /// Services account in this Amazon Web Services Region.
    /// IoT Greengrass uses this role to verify the identity of client devices and
    /// manage core device
    /// connectivity information. For more information, see [Greengrass service
    /// role](https://docs.aws.amazon.com/greengrass/v2/developerguide/greengrass-service-role.html) in
    /// the *IoT Greengrass Version 2 Developer Guide*.
    pub fn getServiceRoleForAccount(self: *Self, allocator: std.mem.Allocator, input: get_service_role_for_account.GetServiceRoleForAccountInput, options: get_service_role_for_account.Options) !get_service_role_for_account.GetServiceRoleForAccountOutput {
        return get_service_role_for_account.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of client devices that are associated with a core
    /// device.
    pub fn listClientDevicesAssociatedWithCoreDevice(self: *Self, allocator: std.mem.Allocator, input: list_client_devices_associated_with_core_device.ListClientDevicesAssociatedWithCoreDeviceInput, options: list_client_devices_associated_with_core_device.Options) !list_client_devices_associated_with_core_device.ListClientDevicesAssociatedWithCoreDeviceOutput {
        return list_client_devices_associated_with_core_device.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of all versions for a component. Greater versions
    /// are listed
    /// first.
    pub fn listComponentVersions(self: *Self, allocator: std.mem.Allocator, input: list_component_versions.ListComponentVersionsInput, options: list_component_versions.Options) !list_component_versions.ListComponentVersionsOutput {
        return list_component_versions.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of component summaries. This list includes
    /// components that you
    /// have permission to view.
    pub fn listComponents(self: *Self, allocator: std.mem.Allocator, input: list_components.ListComponentsInput, options: list_components.Options) !list_components.ListComponentsOutput {
        return list_components.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of Greengrass core devices.
    ///
    /// IoT Greengrass relies on individual devices to send status updates to the
    /// Amazon Web Services Cloud. If the
    /// IoT Greengrass Core software isn't running on the device, or if device isn't
    /// connected to the Amazon Web Services Cloud,
    /// then the reported status of that device might not reflect its current
    /// status. The status
    /// timestamp indicates when the device status was last updated.
    ///
    /// Core devices send status updates at the following times:
    ///
    /// * When the IoT Greengrass Core software starts
    ///
    /// * When the core device receives a deployment from the Amazon Web Services
    ///   Cloud
    ///
    /// * For Greengrass nucleus 2.12.2 and earlier, the core device sends status
    ///   updates when the
    /// status of any component on the core device becomes `ERRORED` or
    /// `BROKEN`.
    ///
    /// * For Greengrass nucleus 2.12.3 and later, the core device sends status
    ///   updates when the
    /// status of any component on the core device becomes `ERRORED`,
    /// `BROKEN`, `RUNNING`, or `FINISHED`.
    ///
    /// * At a [regular interval that you can
    ///   configure](https://docs.aws.amazon.com/greengrass/v2/developerguide/greengrass-nucleus-component.html#greengrass-nucleus-component-configuration-fss), which defaults to 24 hours
    ///
    /// * For IoT Greengrass Core v2.7.0, the core device sends status updates upon
    ///   local deployment and
    /// cloud deployment
    pub fn listCoreDevices(self: *Self, allocator: std.mem.Allocator, input: list_core_devices.ListCoreDevicesInput, options: list_core_devices.Options) !list_core_devices.ListCoreDevicesOutput {
        return list_core_devices.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of deployments.
    pub fn listDeployments(self: *Self, allocator: std.mem.Allocator, input: list_deployments.ListDeploymentsInput, options: list_deployments.Options) !list_deployments.ListDeploymentsOutput {
        return list_deployments.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of deployment jobs that IoT Greengrass sends to
    /// Greengrass core devices.
    pub fn listEffectiveDeployments(self: *Self, allocator: std.mem.Allocator, input: list_effective_deployments.ListEffectiveDeploymentsInput, options: list_effective_deployments.Options) !list_effective_deployments.ListEffectiveDeploymentsOutput {
        return list_effective_deployments.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of the components that a Greengrass core device
    /// runs. By default,
    /// this list doesn't include components that are deployed as dependencies of
    /// other components. To
    /// include dependencies in the response, set the `topologyFilter` parameter to
    /// `ALL`.
    ///
    /// IoT Greengrass relies on individual devices to send status updates to the
    /// Amazon Web Services Cloud. If the
    /// IoT Greengrass Core software isn't running on the device, or if device isn't
    /// connected to the Amazon Web Services Cloud,
    /// then the reported status of that device might not reflect its current
    /// status. The status
    /// timestamp indicates when the device status was last updated.
    ///
    /// Core devices send status updates at the following times:
    ///
    /// * When the IoT Greengrass Core software starts
    ///
    /// * When the core device receives a deployment from the Amazon Web Services
    ///   Cloud
    ///
    /// * When the status of any component on the core device becomes
    /// `BROKEN`
    ///
    /// * At a [regular interval that you can
    ///   configure](https://docs.aws.amazon.com/greengrass/v2/developerguide/greengrass-nucleus-component.html#greengrass-nucleus-component-configuration-fss), which defaults to 24 hours
    ///
    /// * For IoT Greengrass Core v2.7.0, the core device sends status updates upon
    ///   local deployment and
    /// cloud deployment
    pub fn listInstalledComponents(self: *Self, allocator: std.mem.Allocator, input: list_installed_components.ListInstalledComponentsInput, options: list_installed_components.Options) !list_installed_components.ListInstalledComponentsOutput {
        return list_installed_components.execute(self, allocator, input, options);
    }

    /// Retrieves the list of tags for an IoT Greengrass resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves a list of components that meet the component, version, and
    /// platform requirements
    /// of a deployment. Greengrass core devices call this operation when they
    /// receive a deployment to
    /// identify the components to install.
    ///
    /// This operation identifies components that meet all dependency requirements
    /// for a
    /// deployment. If the requirements conflict, then this operation returns an
    /// error and the
    /// deployment fails. For example, this occurs if component `A` requires version
    /// `>2.0.0` and component `B` requires version `<2.0.0`
    /// of a component dependency.
    ///
    /// When you specify the component candidates to resolve, IoT Greengrass
    /// compares each component's
    /// digest from the core device with the component's digest in the Amazon Web
    /// Services Cloud. If the digests
    /// don't match, then IoT Greengrass specifies to use the version from the
    /// Amazon Web Services Cloud.
    ///
    /// To use this operation, you must use the data plane API endpoint and
    /// authenticate with an
    /// IoT device certificate. For more information, see [IoT Greengrass endpoints
    /// and quotas](https://docs.aws.amazon.com/general/latest/gr/greengrass.html).
    pub fn resolveComponentCandidates(self: *Self, allocator: std.mem.Allocator, input: resolve_component_candidates.ResolveComponentCandidatesInput, options: resolve_component_candidates.Options) !resolve_component_candidates.ResolveComponentCandidatesOutput {
        return resolve_component_candidates.execute(self, allocator, input, options);
    }

    /// Adds tags to an IoT Greengrass resource. If a tag already exists for the
    /// resource, this operation
    /// updates the tag's value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from an IoT Greengrass resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates connectivity information for a Greengrass core device.
    ///
    /// Connectivity information includes endpoints and ports where client devices
    /// can connect to an MQTT broker on the core device. When a client device
    /// calls the [IoT Greengrass discovery
    /// API](https://docs.aws.amazon.com/greengrass/v2/developerguide/greengrass-discover-api.html),
    /// IoT Greengrass returns connectivity information for all of the core devices
    /// where the client device can
    /// connect. For more information, see [Connect client devices to
    /// core
    /// devices](https://docs.aws.amazon.com/greengrass/v2/developerguide/connect-client-devices.html) in the *IoT Greengrass Version 2 Developer Guide*.
    pub fn updateConnectivityInfo(self: *Self, allocator: std.mem.Allocator, input: update_connectivity_info.UpdateConnectivityInfoInput, options: update_connectivity_info.Options) !update_connectivity_info.UpdateConnectivityInfoOutput {
        return update_connectivity_info.execute(self, allocator, input, options);
    }

    pub fn listClientDevicesAssociatedWithCoreDevicePaginator(self: *Self, params: list_client_devices_associated_with_core_device.ListClientDevicesAssociatedWithCoreDeviceInput) paginator.ListClientDevicesAssociatedWithCoreDevicePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComponentVersionsPaginator(self: *Self, params: list_component_versions.ListComponentVersionsInput) paginator.ListComponentVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComponentsPaginator(self: *Self, params: list_components.ListComponentsInput) paginator.ListComponentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCoreDevicesPaginator(self: *Self, params: list_core_devices.ListCoreDevicesInput) paginator.ListCoreDevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDeploymentsPaginator(self: *Self, params: list_deployments.ListDeploymentsInput) paginator.ListDeploymentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEffectiveDeploymentsPaginator(self: *Self, params: list_effective_deployments.ListEffectiveDeploymentsInput) paginator.ListEffectiveDeploymentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstalledComponentsPaginator(self: *Self, params: list_installed_components.ListInstalledComponentsInput) paginator.ListInstalledComponentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
