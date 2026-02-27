const aws = @import("aws");
const std = @import("std");

const create_broker = @import("create_broker.zig");
const create_configuration = @import("create_configuration.zig");
const create_tags = @import("create_tags.zig");
const create_user = @import("create_user.zig");
const delete_broker = @import("delete_broker.zig");
const delete_configuration = @import("delete_configuration.zig");
const delete_tags = @import("delete_tags.zig");
const delete_user = @import("delete_user.zig");
const describe_broker = @import("describe_broker.zig");
const describe_broker_engine_types = @import("describe_broker_engine_types.zig");
const describe_broker_instance_options = @import("describe_broker_instance_options.zig");
const describe_configuration = @import("describe_configuration.zig");
const describe_configuration_revision = @import("describe_configuration_revision.zig");
const describe_user = @import("describe_user.zig");
const list_brokers = @import("list_brokers.zig");
const list_configuration_revisions = @import("list_configuration_revisions.zig");
const list_configurations = @import("list_configurations.zig");
const list_tags = @import("list_tags.zig");
const list_users = @import("list_users.zig");
const promote_ = @import("promote.zig");
const reboot_broker = @import("reboot_broker.zig");
const update_broker = @import("update_broker.zig");
const update_configuration = @import("update_configuration.zig");
const update_user = @import("update_user.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "mq";

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

    /// Creates a broker. Note: This API is asynchronous.
    ///
    /// To create a broker, you must either use the AmazonMQFullAccess IAM policy or
    /// include the following EC2 permissions in your IAM policy.
    ///
    /// * ec2:CreateNetworkInterface
    ///
    /// This permission is required to allow Amazon MQ to create an elastic network
    /// interface (ENI) on behalf of your account.
    /// * ec2:CreateNetworkInterfacePermission
    ///
    /// This permission is required to attach the ENI to the broker instance.
    /// * ec2:DeleteNetworkInterface
    /// * ec2:DeleteNetworkInterfacePermission
    /// * ec2:DetachNetworkInterface
    /// * ec2:DescribeInternetGateways
    /// * ec2:DescribeNetworkInterfaces
    /// * ec2:DescribeNetworkInterfacePermissions
    /// * ec2:DescribeRouteTables
    /// * ec2:DescribeSecurityGroups
    /// * ec2:DescribeSubnets
    /// * ec2:DescribeVpcs
    ///
    /// For more information, see [Create an IAM User and Get Your Amazon Web
    /// Services
    /// Credentials](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/amazon-mq-setting-up.html#create-iam-user) and [Never Modify or Delete the Amazon MQ Elastic Network Interface](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/connecting-to-amazon-mq.html#never-modify-delete-elastic-network-interface) in the *Amazon MQ Developer Guide*.
    pub fn createBroker(self: *Self, allocator: std.mem.Allocator, input: create_broker.CreateBrokerInput, options: create_broker.Options) !create_broker.CreateBrokerOutput {
        return create_broker.execute(self, allocator, input, options);
    }

    /// Creates a new configuration for the specified configuration name. Amazon MQ
    /// uses the default configuration (the engine type and version).
    pub fn createConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_configuration.CreateConfigurationInput, options: create_configuration.Options) !create_configuration.CreateConfigurationOutput {
        return create_configuration.execute(self, allocator, input, options);
    }

    /// Add a tag to a resource.
    pub fn createTags(self: *Self, allocator: std.mem.Allocator, input: create_tags.CreateTagsInput, options: create_tags.Options) !create_tags.CreateTagsOutput {
        return create_tags.execute(self, allocator, input, options);
    }

    /// Creates an ActiveMQ user.
    ///
    /// Do not add personally identifiable information (PII) or other confidential
    /// or sensitive information in broker usernames. Broker usernames are
    /// accessible to other Amazon Web Services services, including CloudWatch Logs.
    /// Broker usernames are not intended to be used for private or sensitive data.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: create_user.Options) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Deletes a broker. Note: This API is asynchronous.
    pub fn deleteBroker(self: *Self, allocator: std.mem.Allocator, input: delete_broker.DeleteBrokerInput, options: delete_broker.Options) !delete_broker.DeleteBrokerOutput {
        return delete_broker.execute(self, allocator, input, options);
    }

    /// Deletes the specified configuration.
    pub fn deleteConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_configuration.DeleteConfigurationInput, options: delete_configuration.Options) !delete_configuration.DeleteConfigurationOutput {
        return delete_configuration.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn deleteTags(self: *Self, allocator: std.mem.Allocator, input: delete_tags.DeleteTagsInput, options: delete_tags.Options) !delete_tags.DeleteTagsOutput {
        return delete_tags.execute(self, allocator, input, options);
    }

    /// Deletes an ActiveMQ user.
    pub fn deleteUser(self: *Self, allocator: std.mem.Allocator, input: delete_user.DeleteUserInput, options: delete_user.Options) !delete_user.DeleteUserOutput {
        return delete_user.execute(self, allocator, input, options);
    }

    /// Returns information about the specified broker.
    pub fn describeBroker(self: *Self, allocator: std.mem.Allocator, input: describe_broker.DescribeBrokerInput, options: describe_broker.Options) !describe_broker.DescribeBrokerOutput {
        return describe_broker.execute(self, allocator, input, options);
    }

    /// Describe available engine types and versions.
    pub fn describeBrokerEngineTypes(self: *Self, allocator: std.mem.Allocator, input: describe_broker_engine_types.DescribeBrokerEngineTypesInput, options: describe_broker_engine_types.Options) !describe_broker_engine_types.DescribeBrokerEngineTypesOutput {
        return describe_broker_engine_types.execute(self, allocator, input, options);
    }

    /// Describe available broker instance options.
    pub fn describeBrokerInstanceOptions(self: *Self, allocator: std.mem.Allocator, input: describe_broker_instance_options.DescribeBrokerInstanceOptionsInput, options: describe_broker_instance_options.Options) !describe_broker_instance_options.DescribeBrokerInstanceOptionsOutput {
        return describe_broker_instance_options.execute(self, allocator, input, options);
    }

    /// Returns information about the specified configuration.
    pub fn describeConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_configuration.DescribeConfigurationInput, options: describe_configuration.Options) !describe_configuration.DescribeConfigurationOutput {
        return describe_configuration.execute(self, allocator, input, options);
    }

    /// Returns the specified configuration revision for the specified
    /// configuration.
    pub fn describeConfigurationRevision(self: *Self, allocator: std.mem.Allocator, input: describe_configuration_revision.DescribeConfigurationRevisionInput, options: describe_configuration_revision.Options) !describe_configuration_revision.DescribeConfigurationRevisionOutput {
        return describe_configuration_revision.execute(self, allocator, input, options);
    }

    /// Returns information about an ActiveMQ user.
    pub fn describeUser(self: *Self, allocator: std.mem.Allocator, input: describe_user.DescribeUserInput, options: describe_user.Options) !describe_user.DescribeUserOutput {
        return describe_user.execute(self, allocator, input, options);
    }

    /// Returns a list of all brokers.
    pub fn listBrokers(self: *Self, allocator: std.mem.Allocator, input: list_brokers.ListBrokersInput, options: list_brokers.Options) !list_brokers.ListBrokersOutput {
        return list_brokers.execute(self, allocator, input, options);
    }

    /// Returns a list of all revisions for the specified configuration.
    pub fn listConfigurationRevisions(self: *Self, allocator: std.mem.Allocator, input: list_configuration_revisions.ListConfigurationRevisionsInput, options: list_configuration_revisions.Options) !list_configuration_revisions.ListConfigurationRevisionsOutput {
        return list_configuration_revisions.execute(self, allocator, input, options);
    }

    /// Returns a list of all configurations.
    pub fn listConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_configurations.ListConfigurationsInput, options: list_configurations.Options) !list_configurations.ListConfigurationsOutput {
        return list_configurations.execute(self, allocator, input, options);
    }

    /// Lists tags for a resource.
    pub fn listTags(self: *Self, allocator: std.mem.Allocator, input: list_tags.ListTagsInput, options: list_tags.Options) !list_tags.ListTagsOutput {
        return list_tags.execute(self, allocator, input, options);
    }

    /// Returns a list of all ActiveMQ users.
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: list_users.Options) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Promotes a data replication replica broker to the primary broker role.
    pub fn promote(self: *Self, allocator: std.mem.Allocator, input: promote_.PromoteInput, options: promote_.Options) !promote_.PromoteOutput {
        return promote_.execute(self, allocator, input, options);
    }

    /// Reboots a broker. Note: This API is asynchronous.
    pub fn rebootBroker(self: *Self, allocator: std.mem.Allocator, input: reboot_broker.RebootBrokerInput, options: reboot_broker.Options) !reboot_broker.RebootBrokerOutput {
        return reboot_broker.execute(self, allocator, input, options);
    }

    /// Adds a pending configuration change to a broker.
    pub fn updateBroker(self: *Self, allocator: std.mem.Allocator, input: update_broker.UpdateBrokerInput, options: update_broker.Options) !update_broker.UpdateBrokerOutput {
        return update_broker.execute(self, allocator, input, options);
    }

    /// Updates the specified configuration.
    pub fn updateConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_configuration.UpdateConfigurationInput, options: update_configuration.Options) !update_configuration.UpdateConfigurationOutput {
        return update_configuration.execute(self, allocator, input, options);
    }

    /// Updates the information for an ActiveMQ user.
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: update_user.Options) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    pub fn listBrokersPaginator(self: *Self, params: list_brokers.ListBrokersInput) paginator.ListBrokersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
