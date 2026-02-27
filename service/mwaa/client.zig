const aws = @import("aws");
const std = @import("std");

const create_cli_token = @import("create_cli_token.zig");
const create_environment = @import("create_environment.zig");
const create_web_login_token = @import("create_web_login_token.zig");
const delete_environment = @import("delete_environment.zig");
const get_environment = @import("get_environment.zig");
const invoke_rest_api = @import("invoke_rest_api.zig");
const list_environments = @import("list_environments.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const publish_metrics = @import("publish_metrics.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_environment = @import("update_environment.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MWAA";

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

    /// Creates a CLI token for the Airflow CLI. To learn more, see [Creating an
    /// Apache Airflow CLI
    /// token](https://docs.aws.amazon.com/mwaa/latest/userguide/call-mwaa-apis-cli.html).
    pub fn createCliToken(self: *Self, allocator: std.mem.Allocator, input: create_cli_token.CreateCliTokenInput, options: create_cli_token.Options) !create_cli_token.CreateCliTokenOutput {
        return create_cli_token.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Managed Workflows for Apache Airflow (Amazon MWAA)
    /// environment.
    pub fn createEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_environment.CreateEnvironmentInput, options: create_environment.Options) !create_environment.CreateEnvironmentOutput {
        return create_environment.execute(self, allocator, input, options);
    }

    /// Creates a web login token for the Airflow Web UI. To learn more, see
    /// [Creating an Apache Airflow web login
    /// token](https://docs.aws.amazon.com/mwaa/latest/userguide/call-mwaa-apis-web.html).
    pub fn createWebLoginToken(self: *Self, allocator: std.mem.Allocator, input: create_web_login_token.CreateWebLoginTokenInput, options: create_web_login_token.Options) !create_web_login_token.CreateWebLoginTokenOutput {
        return create_web_login_token.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Managed Workflows for Apache Airflow (Amazon MWAA)
    /// environment.
    pub fn deleteEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_environment.DeleteEnvironmentInput, options: delete_environment.Options) !delete_environment.DeleteEnvironmentOutput {
        return delete_environment.execute(self, allocator, input, options);
    }

    /// Describes an Amazon Managed Workflows for Apache Airflow (MWAA) environment.
    pub fn getEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_environment.GetEnvironmentInput, options: get_environment.Options) !get_environment.GetEnvironmentOutput {
        return get_environment.execute(self, allocator, input, options);
    }

    /// Invokes the Apache Airflow REST API on the webserver with the specified
    /// inputs. To
    /// learn more, see [Using the Apache Airflow REST
    /// API](https://docs.aws.amazon.com/mwaa/latest/userguide/access-mwaa-apache-airflow-rest-api.html)
    pub fn invokeRestApi(self: *Self, allocator: std.mem.Allocator, input: invoke_rest_api.InvokeRestApiInput, options: invoke_rest_api.Options) !invoke_rest_api.InvokeRestApiOutput {
        return invoke_rest_api.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Managed Workflows for Apache Airflow (MWAA) environments.
    pub fn listEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_environments.ListEnvironmentsInput, options: list_environments.Options) !list_environments.ListEnvironmentsOutput {
        return list_environments.execute(self, allocator, input, options);
    }

    /// Lists the key-value tag pairs associated to the Amazon Managed Workflows for
    /// Apache Airflow (MWAA) environment. For example, `"Environment": "Staging"`.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// **Internal only**. Publishes environment health metrics to Amazon
    /// CloudWatch.
    pub fn publishMetrics(self: *Self, allocator: std.mem.Allocator, input: publish_metrics.PublishMetricsInput, options: publish_metrics.Options) !publish_metrics.PublishMetricsOutput {
        return publish_metrics.execute(self, allocator, input, options);
    }

    /// Associates key-value tag pairs to your Amazon Managed Workflows for Apache
    /// Airflow (MWAA) environment.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes key-value tag pairs associated to your Amazon Managed Workflows for
    /// Apache Airflow (MWAA) environment. For example, `"Environment": "Staging"`.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Managed Workflows for Apache Airflow (MWAA) environment.
    pub fn updateEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_environment.UpdateEnvironmentInput, options: update_environment.Options) !update_environment.UpdateEnvironmentOutput {
        return update_environment.execute(self, allocator, input, options);
    }

    pub fn listEnvironmentsPaginator(self: *Self, params: list_environments.ListEnvironmentsInput) paginator.ListEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
