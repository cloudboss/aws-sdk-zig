const aws = @import("aws");
const std = @import("std");

const create_application_instance = @import("create_application_instance.zig");
const create_job_for_devices = @import("create_job_for_devices.zig");
const create_node_from_template_job = @import("create_node_from_template_job.zig");
const create_package = @import("create_package.zig");
const create_package_import_job = @import("create_package_import_job.zig");
const delete_device = @import("delete_device.zig");
const delete_package = @import("delete_package.zig");
const deregister_package_version = @import("deregister_package_version.zig");
const describe_application_instance = @import("describe_application_instance.zig");
const describe_application_instance_details = @import("describe_application_instance_details.zig");
const describe_device = @import("describe_device.zig");
const describe_device_job = @import("describe_device_job.zig");
const describe_node = @import("describe_node.zig");
const describe_node_from_template_job = @import("describe_node_from_template_job.zig");
const describe_package = @import("describe_package.zig");
const describe_package_import_job = @import("describe_package_import_job.zig");
const describe_package_version = @import("describe_package_version.zig");
const list_application_instance_dependencies = @import("list_application_instance_dependencies.zig");
const list_application_instance_node_instances = @import("list_application_instance_node_instances.zig");
const list_application_instances = @import("list_application_instances.zig");
const list_devices = @import("list_devices.zig");
const list_devices_jobs = @import("list_devices_jobs.zig");
const list_node_from_template_jobs = @import("list_node_from_template_jobs.zig");
const list_nodes = @import("list_nodes.zig");
const list_package_import_jobs = @import("list_package_import_jobs.zig");
const list_packages = @import("list_packages.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const provision_device = @import("provision_device.zig");
const register_package_version = @import("register_package_version.zig");
const remove_application_instance = @import("remove_application_instance.zig");
const signal_application_instance_node_instances = @import("signal_application_instance_node_instances.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_device_metadata = @import("update_device_metadata.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Panorama";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates an application instance and deploys it to a device.
    pub fn createApplicationInstance(self: *Self, allocator: std.mem.Allocator, input: create_application_instance.CreateApplicationInstanceInput, options: CallOptions) !create_application_instance.CreateApplicationInstanceOutput {
        return create_application_instance.execute(self, allocator, input, options);
    }

    /// Creates a job to run on a device. A job can update a device's software or
    /// reboot it.
    pub fn createJobForDevices(self: *Self, allocator: std.mem.Allocator, input: create_job_for_devices.CreateJobForDevicesInput, options: CallOptions) !create_job_for_devices.CreateJobForDevicesOutput {
        return create_job_for_devices.execute(self, allocator, input, options);
    }

    /// Creates a camera stream node.
    pub fn createNodeFromTemplateJob(self: *Self, allocator: std.mem.Allocator, input: create_node_from_template_job.CreateNodeFromTemplateJobInput, options: CallOptions) !create_node_from_template_job.CreateNodeFromTemplateJobOutput {
        return create_node_from_template_job.execute(self, allocator, input, options);
    }

    /// Creates a package and storage location in an Amazon S3 access point.
    pub fn createPackage(self: *Self, allocator: std.mem.Allocator, input: create_package.CreatePackageInput, options: CallOptions) !create_package.CreatePackageOutput {
        return create_package.execute(self, allocator, input, options);
    }

    /// Imports a node package.
    pub fn createPackageImportJob(self: *Self, allocator: std.mem.Allocator, input: create_package_import_job.CreatePackageImportJobInput, options: CallOptions) !create_package_import_job.CreatePackageImportJobOutput {
        return create_package_import_job.execute(self, allocator, input, options);
    }

    /// Deletes a device.
    pub fn deleteDevice(self: *Self, allocator: std.mem.Allocator, input: delete_device.DeleteDeviceInput, options: CallOptions) !delete_device.DeleteDeviceOutput {
        return delete_device.execute(self, allocator, input, options);
    }

    /// Deletes a package.
    ///
    /// To delete a package, you need permission to call `s3:DeleteObject` in
    /// addition to permissions for
    /// the AWS Panorama API.
    pub fn deletePackage(self: *Self, allocator: std.mem.Allocator, input: delete_package.DeletePackageInput, options: CallOptions) !delete_package.DeletePackageOutput {
        return delete_package.execute(self, allocator, input, options);
    }

    /// Deregisters a package version.
    pub fn deregisterPackageVersion(self: *Self, allocator: std.mem.Allocator, input: deregister_package_version.DeregisterPackageVersionInput, options: CallOptions) !deregister_package_version.DeregisterPackageVersionOutput {
        return deregister_package_version.execute(self, allocator, input, options);
    }

    /// Returns information about an application instance on a device.
    pub fn describeApplicationInstance(self: *Self, allocator: std.mem.Allocator, input: describe_application_instance.DescribeApplicationInstanceInput, options: CallOptions) !describe_application_instance.DescribeApplicationInstanceOutput {
        return describe_application_instance.execute(self, allocator, input, options);
    }

    /// Returns information about an application instance's configuration manifest.
    pub fn describeApplicationInstanceDetails(self: *Self, allocator: std.mem.Allocator, input: describe_application_instance_details.DescribeApplicationInstanceDetailsInput, options: CallOptions) !describe_application_instance_details.DescribeApplicationInstanceDetailsOutput {
        return describe_application_instance_details.execute(self, allocator, input, options);
    }

    /// Returns information about a device.
    pub fn describeDevice(self: *Self, allocator: std.mem.Allocator, input: describe_device.DescribeDeviceInput, options: CallOptions) !describe_device.DescribeDeviceOutput {
        return describe_device.execute(self, allocator, input, options);
    }

    /// Returns information about a device job.
    pub fn describeDeviceJob(self: *Self, allocator: std.mem.Allocator, input: describe_device_job.DescribeDeviceJobInput, options: CallOptions) !describe_device_job.DescribeDeviceJobOutput {
        return describe_device_job.execute(self, allocator, input, options);
    }

    /// Returns information about a node.
    pub fn describeNode(self: *Self, allocator: std.mem.Allocator, input: describe_node.DescribeNodeInput, options: CallOptions) !describe_node.DescribeNodeOutput {
        return describe_node.execute(self, allocator, input, options);
    }

    /// Returns information about a job to create a camera stream node.
    pub fn describeNodeFromTemplateJob(self: *Self, allocator: std.mem.Allocator, input: describe_node_from_template_job.DescribeNodeFromTemplateJobInput, options: CallOptions) !describe_node_from_template_job.DescribeNodeFromTemplateJobOutput {
        return describe_node_from_template_job.execute(self, allocator, input, options);
    }

    /// Returns information about a package.
    pub fn describePackage(self: *Self, allocator: std.mem.Allocator, input: describe_package.DescribePackageInput, options: CallOptions) !describe_package.DescribePackageOutput {
        return describe_package.execute(self, allocator, input, options);
    }

    /// Returns information about a package import job.
    pub fn describePackageImportJob(self: *Self, allocator: std.mem.Allocator, input: describe_package_import_job.DescribePackageImportJobInput, options: CallOptions) !describe_package_import_job.DescribePackageImportJobOutput {
        return describe_package_import_job.execute(self, allocator, input, options);
    }

    /// Returns information about a package version.
    pub fn describePackageVersion(self: *Self, allocator: std.mem.Allocator, input: describe_package_version.DescribePackageVersionInput, options: CallOptions) !describe_package_version.DescribePackageVersionOutput {
        return describe_package_version.execute(self, allocator, input, options);
    }

    /// Returns a list of application instance dependencies.
    pub fn listApplicationInstanceDependencies(self: *Self, allocator: std.mem.Allocator, input: list_application_instance_dependencies.ListApplicationInstanceDependenciesInput, options: CallOptions) !list_application_instance_dependencies.ListApplicationInstanceDependenciesOutput {
        return list_application_instance_dependencies.execute(self, allocator, input, options);
    }

    /// Returns a list of application node instances.
    pub fn listApplicationInstanceNodeInstances(self: *Self, allocator: std.mem.Allocator, input: list_application_instance_node_instances.ListApplicationInstanceNodeInstancesInput, options: CallOptions) !list_application_instance_node_instances.ListApplicationInstanceNodeInstancesOutput {
        return list_application_instance_node_instances.execute(self, allocator, input, options);
    }

    /// Returns a list of application instances.
    pub fn listApplicationInstances(self: *Self, allocator: std.mem.Allocator, input: list_application_instances.ListApplicationInstancesInput, options: CallOptions) !list_application_instances.ListApplicationInstancesOutput {
        return list_application_instances.execute(self, allocator, input, options);
    }

    /// Returns a list of devices.
    pub fn listDevices(self: *Self, allocator: std.mem.Allocator, input: list_devices.ListDevicesInput, options: CallOptions) !list_devices.ListDevicesOutput {
        return list_devices.execute(self, allocator, input, options);
    }

    /// Returns a list of jobs.
    pub fn listDevicesJobs(self: *Self, allocator: std.mem.Allocator, input: list_devices_jobs.ListDevicesJobsInput, options: CallOptions) !list_devices_jobs.ListDevicesJobsOutput {
        return list_devices_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of camera stream node jobs.
    pub fn listNodeFromTemplateJobs(self: *Self, allocator: std.mem.Allocator, input: list_node_from_template_jobs.ListNodeFromTemplateJobsInput, options: CallOptions) !list_node_from_template_jobs.ListNodeFromTemplateJobsOutput {
        return list_node_from_template_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of nodes.
    pub fn listNodes(self: *Self, allocator: std.mem.Allocator, input: list_nodes.ListNodesInput, options: CallOptions) !list_nodes.ListNodesOutput {
        return list_nodes.execute(self, allocator, input, options);
    }

    /// Returns a list of package import jobs.
    pub fn listPackageImportJobs(self: *Self, allocator: std.mem.Allocator, input: list_package_import_jobs.ListPackageImportJobsInput, options: CallOptions) !list_package_import_jobs.ListPackageImportJobsOutput {
        return list_package_import_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of packages.
    pub fn listPackages(self: *Self, allocator: std.mem.Allocator, input: list_packages.ListPackagesInput, options: CallOptions) !list_packages.ListPackagesOutput {
        return list_packages.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates a device and returns a configuration archive. The configuration
    /// archive is a ZIP file that contains a
    /// provisioning certificate that is valid for 5 minutes. Name the configuration
    /// archive
    /// `certificates-omni_*device-name*.zip` and transfer it to the device within 5
    /// minutes. Use the included USB storage device and connect it to the USB 3.0
    /// port next to the HDMI output.
    pub fn provisionDevice(self: *Self, allocator: std.mem.Allocator, input: provision_device.ProvisionDeviceInput, options: CallOptions) !provision_device.ProvisionDeviceOutput {
        return provision_device.execute(self, allocator, input, options);
    }

    /// Registers a package version.
    pub fn registerPackageVersion(self: *Self, allocator: std.mem.Allocator, input: register_package_version.RegisterPackageVersionInput, options: CallOptions) !register_package_version.RegisterPackageVersionOutput {
        return register_package_version.execute(self, allocator, input, options);
    }

    /// Removes an application instance.
    pub fn removeApplicationInstance(self: *Self, allocator: std.mem.Allocator, input: remove_application_instance.RemoveApplicationInstanceInput, options: CallOptions) !remove_application_instance.RemoveApplicationInstanceOutput {
        return remove_application_instance.execute(self, allocator, input, options);
    }

    /// Signal camera nodes to stop or resume.
    pub fn signalApplicationInstanceNodeInstances(self: *Self, allocator: std.mem.Allocator, input: signal_application_instance_node_instances.SignalApplicationInstanceNodeInstancesInput, options: CallOptions) !signal_application_instance_node_instances.SignalApplicationInstanceNodeInstancesOutput {
        return signal_application_instance_node_instances.execute(self, allocator, input, options);
    }

    /// Tags a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a device's metadata.
    pub fn updateDeviceMetadata(self: *Self, allocator: std.mem.Allocator, input: update_device_metadata.UpdateDeviceMetadataInput, options: CallOptions) !update_device_metadata.UpdateDeviceMetadataOutput {
        return update_device_metadata.execute(self, allocator, input, options);
    }

    pub fn listApplicationInstanceDependenciesPaginator(self: *Self, params: list_application_instance_dependencies.ListApplicationInstanceDependenciesInput) paginator.ListApplicationInstanceDependenciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationInstanceNodeInstancesPaginator(self: *Self, params: list_application_instance_node_instances.ListApplicationInstanceNodeInstancesInput) paginator.ListApplicationInstanceNodeInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationInstancesPaginator(self: *Self, params: list_application_instances.ListApplicationInstancesInput) paginator.ListApplicationInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevicesPaginator(self: *Self, params: list_devices.ListDevicesInput) paginator.ListDevicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevicesJobsPaginator(self: *Self, params: list_devices_jobs.ListDevicesJobsInput) paginator.ListDevicesJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNodeFromTemplateJobsPaginator(self: *Self, params: list_node_from_template_jobs.ListNodeFromTemplateJobsInput) paginator.ListNodeFromTemplateJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNodesPaginator(self: *Self, params: list_nodes.ListNodesInput) paginator.ListNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPackageImportJobsPaginator(self: *Self, params: list_package_import_jobs.ListPackageImportJobsInput) paginator.ListPackageImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPackagesPaginator(self: *Self, params: list_packages.ListPackagesInput) paginator.ListPackagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
