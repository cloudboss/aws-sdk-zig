const aws = @import("aws");
const std = @import("std");

const cancel_job_run = @import("cancel_job_run.zig");
const create_job_template = @import("create_job_template.zig");
const create_managed_endpoint = @import("create_managed_endpoint.zig");
const create_security_configuration = @import("create_security_configuration.zig");
const create_virtual_cluster = @import("create_virtual_cluster.zig");
const delete_job_template = @import("delete_job_template.zig");
const delete_managed_endpoint = @import("delete_managed_endpoint.zig");
const delete_virtual_cluster = @import("delete_virtual_cluster.zig");
const describe_job_run = @import("describe_job_run.zig");
const describe_job_template = @import("describe_job_template.zig");
const describe_managed_endpoint = @import("describe_managed_endpoint.zig");
const describe_security_configuration = @import("describe_security_configuration.zig");
const describe_virtual_cluster = @import("describe_virtual_cluster.zig");
const get_managed_endpoint_session_credentials = @import("get_managed_endpoint_session_credentials.zig");
const list_job_runs = @import("list_job_runs.zig");
const list_job_templates = @import("list_job_templates.zig");
const list_managed_endpoints = @import("list_managed_endpoints.zig");
const list_security_configurations = @import("list_security_configurations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_virtual_clusters = @import("list_virtual_clusters.zig");
const start_job_run = @import("start_job_run.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "EMR containers";

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

    /// Cancels a job run. A job run is a unit of work, such as a Spark jar, PySpark
    /// script, or
    /// SparkSQL query, that you submit to Amazon EMR on EKS.
    pub fn cancelJobRun(self: *Self, allocator: std.mem.Allocator, input: cancel_job_run.CancelJobRunInput, options: CallOptions) !cancel_job_run.CancelJobRunOutput {
        return cancel_job_run.execute(self, allocator, input, options);
    }

    /// Creates a job template. Job template stores values of StartJobRun API
    /// request in a
    /// template and can be used to start a job run. Job template allows two use
    /// cases: avoid
    /// repeating recurring StartJobRun API request values, enforcing certain values
    /// in StartJobRun
    /// API request.
    pub fn createJobTemplate(self: *Self, allocator: std.mem.Allocator, input: create_job_template.CreateJobTemplateInput, options: CallOptions) !create_job_template.CreateJobTemplateOutput {
        return create_job_template.execute(self, allocator, input, options);
    }

    /// Creates a managed endpoint. A managed endpoint is a gateway that connects
    /// Amazon EMR Studio to Amazon EMR on EKS so that Amazon EMR Studio can
    /// communicate with your virtual cluster.
    pub fn createManagedEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_managed_endpoint.CreateManagedEndpointInput, options: CallOptions) !create_managed_endpoint.CreateManagedEndpointOutput {
        return create_managed_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a security configuration. Security configurations in Amazon EMR on
    /// EKS are
    /// templates for different security setups. You can use security configurations
    /// to configure
    /// the Lake Formation integration setup. You can also create a security
    /// configuration
    /// to re-use a security setup each time you create a virtual cluster.
    pub fn createSecurityConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_security_configuration.CreateSecurityConfigurationInput, options: CallOptions) !create_security_configuration.CreateSecurityConfigurationOutput {
        return create_security_configuration.execute(self, allocator, input, options);
    }

    /// Creates a virtual cluster. Virtual cluster is a managed entity on Amazon EMR
    /// on EKS. You can create, describe, list and delete virtual clusters. They do
    /// not consume any
    /// additional resource in your system. A single virtual cluster maps to a
    /// single Kubernetes
    /// namespace. Given this relationship, you can model virtual clusters the same
    /// way you model
    /// Kubernetes namespaces to meet your requirements.
    pub fn createVirtualCluster(self: *Self, allocator: std.mem.Allocator, input: create_virtual_cluster.CreateVirtualClusterInput, options: CallOptions) !create_virtual_cluster.CreateVirtualClusterOutput {
        return create_virtual_cluster.execute(self, allocator, input, options);
    }

    /// Deletes a job template. Job template stores values of StartJobRun API
    /// request in a
    /// template and can be used to start a job run. Job template allows two use
    /// cases: avoid
    /// repeating recurring StartJobRun API request values, enforcing certain values
    /// in StartJobRun
    /// API request.
    pub fn deleteJobTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_job_template.DeleteJobTemplateInput, options: CallOptions) !delete_job_template.DeleteJobTemplateOutput {
        return delete_job_template.execute(self, allocator, input, options);
    }

    /// Deletes a managed endpoint. A managed endpoint is a gateway that connects
    /// Amazon EMR Studio to Amazon EMR on EKS so that Amazon EMR Studio can
    /// communicate with your virtual cluster.
    pub fn deleteManagedEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_managed_endpoint.DeleteManagedEndpointInput, options: CallOptions) !delete_managed_endpoint.DeleteManagedEndpointOutput {
        return delete_managed_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes a virtual cluster. Virtual cluster is a managed entity on Amazon EMR
    /// on EKS. You can create, describe, list and delete virtual clusters. They do
    /// not consume any
    /// additional resource in your system. A single virtual cluster maps to a
    /// single Kubernetes
    /// namespace. Given this relationship, you can model virtual clusters the same
    /// way you model
    /// Kubernetes namespaces to meet your requirements.
    pub fn deleteVirtualCluster(self: *Self, allocator: std.mem.Allocator, input: delete_virtual_cluster.DeleteVirtualClusterInput, options: CallOptions) !delete_virtual_cluster.DeleteVirtualClusterOutput {
        return delete_virtual_cluster.execute(self, allocator, input, options);
    }

    /// Displays detailed information about a job run. A job run is a unit of work,
    /// such as a
    /// Spark jar, PySpark script, or SparkSQL query, that you submit to Amazon EMR
    /// on EKS.
    pub fn describeJobRun(self: *Self, allocator: std.mem.Allocator, input: describe_job_run.DescribeJobRunInput, options: CallOptions) !describe_job_run.DescribeJobRunOutput {
        return describe_job_run.execute(self, allocator, input, options);
    }

    /// Displays detailed information about a specified job template. Job template
    /// stores values
    /// of StartJobRun API request in a template and can be used to start a job run.
    /// Job template
    /// allows two use cases: avoid repeating recurring StartJobRun API request
    /// values, enforcing
    /// certain values in StartJobRun API request.
    pub fn describeJobTemplate(self: *Self, allocator: std.mem.Allocator, input: describe_job_template.DescribeJobTemplateInput, options: CallOptions) !describe_job_template.DescribeJobTemplateOutput {
        return describe_job_template.execute(self, allocator, input, options);
    }

    /// Displays detailed information about a managed endpoint. A managed endpoint
    /// is a gateway
    /// that connects Amazon EMR Studio to Amazon EMR on EKS so that Amazon EMR
    /// Studio can communicate with your virtual cluster.
    pub fn describeManagedEndpoint(self: *Self, allocator: std.mem.Allocator, input: describe_managed_endpoint.DescribeManagedEndpointInput, options: CallOptions) !describe_managed_endpoint.DescribeManagedEndpointOutput {
        return describe_managed_endpoint.execute(self, allocator, input, options);
    }

    /// Displays detailed information about a specified security configuration.
    /// Security
    /// configurations in Amazon EMR on EKS are templates for different security
    /// setups. You
    /// can use security configurations to configure the Lake Formation integration
    /// setup.
    /// You can also create a security configuration to re-use a security setup each
    /// time you
    /// create a virtual cluster.
    pub fn describeSecurityConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_security_configuration.DescribeSecurityConfigurationInput, options: CallOptions) !describe_security_configuration.DescribeSecurityConfigurationOutput {
        return describe_security_configuration.execute(self, allocator, input, options);
    }

    /// Displays detailed information about a specified virtual cluster. Virtual
    /// cluster is a
    /// managed entity on Amazon EMR on EKS. You can create, describe, list and
    /// delete virtual
    /// clusters. They do not consume any additional resource in your system. A
    /// single virtual
    /// cluster maps to a single Kubernetes namespace. Given this relationship, you
    /// can model
    /// virtual clusters the same way you model Kubernetes namespaces to meet your
    /// requirements.
    pub fn describeVirtualCluster(self: *Self, allocator: std.mem.Allocator, input: describe_virtual_cluster.DescribeVirtualClusterInput, options: CallOptions) !describe_virtual_cluster.DescribeVirtualClusterOutput {
        return describe_virtual_cluster.execute(self, allocator, input, options);
    }

    /// Generate a session token to connect to a managed endpoint.
    pub fn getManagedEndpointSessionCredentials(self: *Self, allocator: std.mem.Allocator, input: get_managed_endpoint_session_credentials.GetManagedEndpointSessionCredentialsInput, options: CallOptions) !get_managed_endpoint_session_credentials.GetManagedEndpointSessionCredentialsOutput {
        return get_managed_endpoint_session_credentials.execute(self, allocator, input, options);
    }

    /// Lists job runs based on a set of parameters. A job run is a unit of work,
    /// such as a
    /// Spark jar, PySpark script, or SparkSQL query, that you submit to Amazon EMR
    /// on EKS.
    pub fn listJobRuns(self: *Self, allocator: std.mem.Allocator, input: list_job_runs.ListJobRunsInput, options: CallOptions) !list_job_runs.ListJobRunsOutput {
        return list_job_runs.execute(self, allocator, input, options);
    }

    /// Lists job templates based on a set of parameters. Job template stores values
    /// of
    /// StartJobRun API request in a template and can be used to start a job run.
    /// Job template
    /// allows two use cases: avoid repeating recurring StartJobRun API request
    /// values, enforcing
    /// certain values in StartJobRun API request.
    pub fn listJobTemplates(self: *Self, allocator: std.mem.Allocator, input: list_job_templates.ListJobTemplatesInput, options: CallOptions) !list_job_templates.ListJobTemplatesOutput {
        return list_job_templates.execute(self, allocator, input, options);
    }

    /// Lists managed endpoints based on a set of parameters. A managed endpoint is
    /// a gateway
    /// that connects Amazon EMR Studio to Amazon EMR on EKS so that Amazon EMR
    /// Studio can communicate with your virtual cluster.
    pub fn listManagedEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_managed_endpoints.ListManagedEndpointsInput, options: CallOptions) !list_managed_endpoints.ListManagedEndpointsOutput {
        return list_managed_endpoints.execute(self, allocator, input, options);
    }

    /// Lists security configurations based on a set of parameters. Security
    /// configurations in
    /// Amazon EMR on EKS are templates for different security setups. You can use
    /// security
    /// configurations to configure the Lake Formation integration setup. You can
    /// also
    /// create a security configuration to re-use a security setup each time you
    /// create a virtual
    /// cluster.
    pub fn listSecurityConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_security_configurations.ListSecurityConfigurationsInput, options: CallOptions) !list_security_configurations.ListSecurityConfigurationsOutput {
        return list_security_configurations.execute(self, allocator, input, options);
    }

    /// Lists the tags assigned to the resources.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists information about the specified virtual cluster. Virtual cluster is a
    /// managed
    /// entity on Amazon EMR on EKS. You can create, describe, list and delete
    /// virtual
    /// clusters. They do not consume any additional resource in your system. A
    /// single virtual
    /// cluster maps to a single Kubernetes namespace. Given this relationship, you
    /// can model
    /// virtual clusters the same way you model Kubernetes namespaces to meet your
    /// requirements.
    pub fn listVirtualClusters(self: *Self, allocator: std.mem.Allocator, input: list_virtual_clusters.ListVirtualClustersInput, options: CallOptions) !list_virtual_clusters.ListVirtualClustersOutput {
        return list_virtual_clusters.execute(self, allocator, input, options);
    }

    /// Starts a job run. A job run is a unit of work, such as a Spark jar, PySpark
    /// script, or
    /// SparkSQL query, that you submit to Amazon EMR on EKS.
    pub fn startJobRun(self: *Self, allocator: std.mem.Allocator, input: start_job_run.StartJobRunInput, options: CallOptions) !start_job_run.StartJobRunOutput {
        return start_job_run.execute(self, allocator, input, options);
    }

    /// Assigns tags to resources. A tag is a label that you assign to an Amazon Web
    /// Services
    /// resource. Each tag consists of a key and an optional value, both of which
    /// you define. Tags
    /// enable you to categorize your Amazon Web Services resources by attributes
    /// such as purpose,
    /// owner, or environment. When you have many resources of the same type, you
    /// can quickly
    /// identify a specific resource based on the tags you've assigned to it. For
    /// example, you can
    /// define a set of tags for your Amazon EMR on EKS clusters to help you track
    /// each
    /// cluster's owner and stack level. We recommend that you devise a consistent
    /// set of tag keys
    /// for each resource type. You can then search and filter the resources based
    /// on the tags that
    /// you add.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from resources.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listJobRunsPaginator(self: *Self, params: list_job_runs.ListJobRunsInput) paginator.ListJobRunsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobTemplatesPaginator(self: *Self, params: list_job_templates.ListJobTemplatesInput) paginator.ListJobTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedEndpointsPaginator(self: *Self, params: list_managed_endpoints.ListManagedEndpointsInput) paginator.ListManagedEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityConfigurationsPaginator(self: *Self, params: list_security_configurations.ListSecurityConfigurationsInput) paginator.ListSecurityConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVirtualClustersPaginator(self: *Self, params: list_virtual_clusters.ListVirtualClustersInput) paginator.ListVirtualClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
