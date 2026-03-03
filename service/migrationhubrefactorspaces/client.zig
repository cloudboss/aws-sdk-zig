const aws = @import("aws");
const std = @import("std");

const create_application = @import("create_application.zig");
const create_environment = @import("create_environment.zig");
const create_route = @import("create_route.zig");
const create_service = @import("create_service.zig");
const delete_application = @import("delete_application.zig");
const delete_environment = @import("delete_environment.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_route = @import("delete_route.zig");
const delete_service = @import("delete_service.zig");
const get_application = @import("get_application.zig");
const get_environment = @import("get_environment.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_route = @import("get_route.zig");
const get_service = @import("get_service.zig");
const list_applications = @import("list_applications.zig");
const list_environment_vpcs = @import("list_environment_vpcs.zig");
const list_environments = @import("list_environments.zig");
const list_routes = @import("list_routes.zig");
const list_services = @import("list_services.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_route = @import("update_route.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Migration Hub Refactor Spaces";

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

    /// Creates an Amazon Web Services Migration Hub Refactor Spaces application.
    /// The account that owns the environment also owns the
    /// applications created inside the environment, regardless of the account that
    /// creates the
    /// application. Refactor Spaces provisions an Amazon API Gateway, API Gateway
    /// VPC link, and
    /// Network Load Balancer for the application proxy inside your account.
    ///
    /// In environments created with a
    /// [CreateEnvironment:NetworkFabricType](https://docs.aws.amazon.com/migrationhub-refactor-spaces/latest/APIReference/API_CreateEnvironment.html#migrationhubrefactorspaces-CreateEnvironment-request-NetworkFabricType) of `NONE` you need to configure
    /// [ VPC to VPC
    /// connectivity](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/amazon-vpc-to-amazon-vpc-connectivity-options.html) between your service VPC and the application proxy VPC to
    /// route traffic through the application proxy to a service with a private URL
    /// endpoint. For more
    /// information, see [
    /// Create an
    /// application](https://docs.aws.amazon.com/migrationhub-refactor-spaces/latest/userguide/getting-started-create-application.html) in the *Refactor Spaces User Guide*.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Web Services Migration Hub Refactor Spaces environment.
    /// The caller owns the environment resource, and all
    /// Refactor Spaces applications, services, and routes created within the
    /// environment. They are referred
    /// to as the *environment owner*. The environment owner has cross-account
    /// visibility and control of Refactor Spaces resources that are added to the
    /// environment by other
    /// accounts that the environment is shared with.
    ///
    /// When creating an environment with a
    /// [CreateEnvironment:NetworkFabricType](https://docs.aws.amazon.com/migrationhub-refactor-spaces/latest/APIReference/API_CreateEnvironment.html#migrationhubrefactorspaces-CreateEnvironment-request-NetworkFabricType) of `TRANSIT_GATEWAY`, Refactor Spaces
    /// provisions a transit gateway to enable services in VPCs to communicate
    /// directly across
    /// accounts. If
    /// [CreateEnvironment:NetworkFabricType](https://docs.aws.amazon.com/migrationhub-refactor-spaces/latest/APIReference/API_CreateEnvironment.html#migrationhubrefactorspaces-CreateEnvironment-request-NetworkFabricType) is `NONE`, Refactor Spaces does not create
    /// a transit gateway and you must use your network infrastructure to route
    /// traffic to services
    /// with private URL endpoints.
    pub fn createEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_environment.CreateEnvironmentInput, options: create_environment.Options) !create_environment.CreateEnvironmentOutput {
        return create_environment.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Web Services Migration Hub Refactor Spaces route. The
    /// account owner of the service resource is always the
    /// environment owner, regardless of which account creates the route. Routes
    /// target a service in
    /// the application. If an application does not have any routes, then the first
    /// route must be
    /// created as a `DEFAULT`
    /// `RouteType`.
    ///
    /// When created, the default route defaults to an active state so state is not
    /// a required
    /// input. However, like all other state values the state of the default route
    /// can be updated
    /// after creation, but only when all other routes are also inactive.
    /// Conversely, no route can be
    /// active without the default route also being active.
    ///
    /// When you create a route, Refactor Spaces configures the Amazon API Gateway
    /// to send traffic
    /// to the target service as follows:
    ///
    /// * **URL Endpoints**
    ///
    /// If the service has a URL endpoint, and the endpoint resolves to a private IP
    /// address,
    /// Refactor Spaces routes traffic using the API Gateway VPC link. If a service
    /// endpoint
    /// resolves to a public IP address, Refactor Spaces routes traffic over the
    /// public internet.
    /// Services can have HTTP or HTTPS URL endpoints. For HTTPS URLs,
    /// publicly-signed
    /// certificates are supported. Private Certificate Authorities (CAs) are
    /// permitted only if
    /// the CA's domain is also publicly resolvable.
    ///
    /// Refactor Spaces automatically resolves the public Domain Name System (DNS)
    /// names that are
    /// set in `CreateService:UrlEndpoint `when you create a service. The DNS names
    /// resolve when the DNS time-to-live (TTL) expires, or every 60 seconds for
    /// TTLs less than 60
    /// seconds. This periodic DNS resolution ensures that the route configuration
    /// remains
    /// up-to-date.
    ///
    /// **One-time health check**
    ///
    /// A one-time health check is performed on the service when either the route is
    /// updated
    /// from inactive to active, or when it is created with an active state. If the
    /// health check
    /// fails, the route transitions the route state to `FAILED`, an error code of
    /// `SERVICE_ENDPOINT_HEALTH_CHECK_FAILURE` is provided, and no traffic is sent
    /// to the service.
    ///
    /// For private URLs, a target group is created on the Network Load Balancer and
    /// the load
    /// balancer target group runs default target health checks. By default, the
    /// health check is
    /// run against the service endpoint URL. Optionally, the health check can be
    /// performed
    /// against a different protocol, port, and/or path using the
    /// [CreateService:UrlEndpoint](https://docs.aws.amazon.com/migrationhub-refactor-spaces/latest/APIReference/API_CreateService.html#migrationhubrefactorspaces-CreateService-request-UrlEndpoint) parameter. All other health check settings for the
    /// load balancer use the default values described in the [Health
    /// checks for your target
    /// groups](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/target-group-health-checks.html) in the *Elastic Load Balancing
    /// guide*. The health check is considered successful if at least one target
    /// within the target group transitions to a healthy state.
    ///
    /// * **Lambda function endpoints**
    ///
    /// If the service has an Lambda function endpoint, then Refactor Spaces
    /// configures the Lambda function's resource policy to allow the application's
    /// API Gateway to invoke the function.
    ///
    /// The Lambda function state is checked. If the function is not active, the
    /// function configuration is updated so that Lambda resources are provisioned.
    /// If
    /// the Lambda state is `Failed`, then the route creation fails. For
    /// more information, see the [GetFunctionConfiguration's State response
    /// parameter](https://docs.aws.amazon.com/lambda/latest/dg/API_GetFunctionConfiguration.html#SSS-GetFunctionConfiguration-response-State) in the *Lambda Developer Guide*.
    ///
    /// A check is performed to determine that a Lambda function with the specified
    /// ARN
    /// exists. If it does not exist, the health check fails. For public URLs, a
    /// connection is
    /// opened to the public endpoint. If the URL is not reachable, the health check
    /// fails.
    ///
    /// **Environments without a network bridge**
    ///
    /// When you create environments without a network bridge
    /// ([CreateEnvironment:NetworkFabricType](https://docs.aws.amazon.com/migrationhub-refactor-spaces/latest/APIReference/API_CreateEnvironment.html#migrationhubrefactorspaces-CreateEnvironment-request-NetworkFabricType) is `NONE)` and you use your own
    /// networking infrastructure, you need to configure [VPC to VPC
    /// connectivity](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/amazon-vpc-to-amazon-vpc-connectivity-options.html) between your network and the application proxy VPC. Route
    /// creation from the application proxy to service endpoints will fail if your
    /// network is not
    /// configured to connect to the application proxy VPC. For more information,
    /// see [ Create
    /// a
    /// route](https://docs.aws.amazon.com/migrationhub-refactor-spaces/latest/userguide/getting-started-create-role.html) in the *Refactor Spaces User Guide*.
    pub fn createRoute(self: *Self, allocator: std.mem.Allocator, input: create_route.CreateRouteInput, options: create_route.Options) !create_route.CreateRouteOutput {
        return create_route.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Web Services Migration Hub Refactor Spaces service. The
    /// account owner of the service is always the
    /// environment owner, regardless of which account in the environment creates
    /// the service.
    /// Services have either a URL endpoint in a virtual private cloud (VPC), or a
    /// Lambda
    /// function endpoint.
    ///
    /// If an Amazon Web Services resource is launched in a service VPC, and you
    /// want it to be
    /// accessible to all of an environment’s services with VPCs and routes, apply
    /// the
    /// `RefactorSpacesSecurityGroup` to the resource. Alternatively, to add more
    /// cross-account constraints, apply your own security group.
    pub fn createService(self: *Self, allocator: std.mem.Allocator, input: create_service.CreateServiceInput, options: create_service.Options) !create_service.CreateServiceOutput {
        return create_service.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Web Services Migration Hub Refactor Spaces application.
    /// Before you can delete an application, you must first
    /// delete any services or routes within the application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: delete_application.Options) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Web Services Migration Hub Refactor Spaces environment.
    /// Before you can delete an environment, you must first
    /// delete any applications and services within the environment.
    pub fn deleteEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_environment.DeleteEnvironmentInput, options: delete_environment.Options) !delete_environment.DeleteEnvironmentOutput {
        return delete_environment.execute(self, allocator, input, options);
    }

    /// Deletes the resource policy set for the environment.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Web Services Migration Hub Refactor Spaces route.
    pub fn deleteRoute(self: *Self, allocator: std.mem.Allocator, input: delete_route.DeleteRouteInput, options: delete_route.Options) !delete_route.DeleteRouteOutput {
        return delete_route.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Web Services Migration Hub Refactor Spaces service.
    pub fn deleteService(self: *Self, allocator: std.mem.Allocator, input: delete_service.DeleteServiceInput, options: delete_service.Options) !delete_service.DeleteServiceOutput {
        return delete_service.execute(self, allocator, input, options);
    }

    /// Gets an Amazon Web Services Migration Hub Refactor Spaces application.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: get_application.Options) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Gets an Amazon Web Services Migration Hub Refactor Spaces environment.
    pub fn getEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_environment.GetEnvironmentInput, options: get_environment.Options) !get_environment.GetEnvironmentOutput {
        return get_environment.execute(self, allocator, input, options);
    }

    /// Gets the resource-based permission policy that is set for the given
    /// environment.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: get_resource_policy.Options) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Gets an Amazon Web Services Migration Hub Refactor Spaces route.
    pub fn getRoute(self: *Self, allocator: std.mem.Allocator, input: get_route.GetRouteInput, options: get_route.Options) !get_route.GetRouteOutput {
        return get_route.execute(self, allocator, input, options);
    }

    /// Gets an Amazon Web Services Migration Hub Refactor Spaces service.
    pub fn getService(self: *Self, allocator: std.mem.Allocator, input: get_service.GetServiceInput, options: get_service.Options) !get_service.GetServiceOutput {
        return get_service.execute(self, allocator, input, options);
    }

    /// Lists all the Amazon Web Services Migration Hub Refactor Spaces applications
    /// within an environment.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: list_applications.Options) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Lists all Amazon Web Services Migration Hub Refactor Spaces service virtual
    /// private clouds (VPCs) that are part of the
    /// environment.
    pub fn listEnvironmentVpcs(self: *Self, allocator: std.mem.Allocator, input: list_environment_vpcs.ListEnvironmentVpcsInput, options: list_environment_vpcs.Options) !list_environment_vpcs.ListEnvironmentVpcsOutput {
        return list_environment_vpcs.execute(self, allocator, input, options);
    }

    /// Lists Amazon Web Services Migration Hub Refactor Spaces environments owned
    /// by a caller account or shared with the caller
    /// account.
    pub fn listEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_environments.ListEnvironmentsInput, options: list_environments.Options) !list_environments.ListEnvironmentsOutput {
        return list_environments.execute(self, allocator, input, options);
    }

    /// Lists all the Amazon Web Services Migration Hub Refactor Spaces routes
    /// within an application.
    pub fn listRoutes(self: *Self, allocator: std.mem.Allocator, input: list_routes.ListRoutesInput, options: list_routes.Options) !list_routes.ListRoutesOutput {
        return list_routes.execute(self, allocator, input, options);
    }

    /// Lists all the Amazon Web Services Migration Hub Refactor Spaces services
    /// within an application.
    pub fn listServices(self: *Self, allocator: std.mem.Allocator, input: list_services.ListServicesInput, options: list_services.Options) !list_services.ListServicesOutput {
        return list_services.execute(self, allocator, input, options);
    }

    /// Lists the tags of a resource. The caller account must be the same as the
    /// resource’s
    /// `OwnerAccountId`. Listing tags in other accounts is not supported.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Attaches a resource-based permission policy to the Amazon Web Services
    /// Migration Hub Refactor Spaces environment. The policy
    /// must contain the same actions and condition statements as the
    /// `arn:aws:ram::aws:permission/AWSRAMDefaultPermissionRefactorSpacesEnvironment`
    /// permission in Resource Access Manager. The policy must not contain new lines
    /// or blank lines.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Removes the tags of a given resource. Tags are metadata which can be used to
    /// manage a
    /// resource. To tag a resource, the caller account must be the same as the
    /// resource’s
    /// `OwnerAccountId`. Tagging resources in other accounts is not supported.
    ///
    /// Amazon Web Services Migration Hub Refactor Spaces does not propagate tags to
    /// orchestrated resources, such as an
    /// environment’s transit gateway.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Adds to or modifies the tags of the given resource. Tags are metadata which
    /// can be used to
    /// manage a resource. To untag a resource, the caller account must be the same
    /// as the resource’s
    /// `OwnerAccountId`. Untagging resources across accounts is not supported.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Web Services Migration Hub Refactor Spaces route.
    pub fn updateRoute(self: *Self, allocator: std.mem.Allocator, input: update_route.UpdateRouteInput, options: update_route.Options) !update_route.UpdateRouteOutput {
        return update_route.execute(self, allocator, input, options);
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEnvironmentVpcsPaginator(self: *Self, params: list_environment_vpcs.ListEnvironmentVpcsInput) paginator.ListEnvironmentVpcsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEnvironmentsPaginator(self: *Self, params: list_environments.ListEnvironmentsInput) paginator.ListEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRoutesPaginator(self: *Self, params: list_routes.ListRoutesInput) paginator.ListRoutesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServicesPaginator(self: *Self, params: list_services.ListServicesInput) paginator.ListServicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
