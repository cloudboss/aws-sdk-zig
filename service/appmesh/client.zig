const aws = @import("aws");
const std = @import("std");

const create_gateway_route = @import("create_gateway_route.zig");
const create_mesh = @import("create_mesh.zig");
const create_route = @import("create_route.zig");
const create_virtual_gateway = @import("create_virtual_gateway.zig");
const create_virtual_node = @import("create_virtual_node.zig");
const create_virtual_router = @import("create_virtual_router.zig");
const create_virtual_service = @import("create_virtual_service.zig");
const delete_gateway_route = @import("delete_gateway_route.zig");
const delete_mesh = @import("delete_mesh.zig");
const delete_route = @import("delete_route.zig");
const delete_virtual_gateway = @import("delete_virtual_gateway.zig");
const delete_virtual_node = @import("delete_virtual_node.zig");
const delete_virtual_router = @import("delete_virtual_router.zig");
const delete_virtual_service = @import("delete_virtual_service.zig");
const describe_gateway_route = @import("describe_gateway_route.zig");
const describe_mesh = @import("describe_mesh.zig");
const describe_route = @import("describe_route.zig");
const describe_virtual_gateway = @import("describe_virtual_gateway.zig");
const describe_virtual_node = @import("describe_virtual_node.zig");
const describe_virtual_router = @import("describe_virtual_router.zig");
const describe_virtual_service = @import("describe_virtual_service.zig");
const list_gateway_routes = @import("list_gateway_routes.zig");
const list_meshes = @import("list_meshes.zig");
const list_routes = @import("list_routes.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_virtual_gateways = @import("list_virtual_gateways.zig");
const list_virtual_nodes = @import("list_virtual_nodes.zig");
const list_virtual_routers = @import("list_virtual_routers.zig");
const list_virtual_services = @import("list_virtual_services.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_gateway_route = @import("update_gateway_route.zig");
const update_mesh = @import("update_mesh.zig");
const update_route = @import("update_route.zig");
const update_virtual_gateway = @import("update_virtual_gateway.zig");
const update_virtual_node = @import("update_virtual_node.zig");
const update_virtual_router = @import("update_virtual_router.zig");
const update_virtual_service = @import("update_virtual_service.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "App Mesh";

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

    /// Creates a gateway route.
    ///
    /// A gateway route is attached to a virtual gateway and routes traffic to an
    /// existing
    /// virtual service. If a route matches a request, it can distribute traffic to
    /// a target
    /// virtual service.
    ///
    /// For more information about gateway routes, see [Gateway
    /// routes](https://docs.aws.amazon.com/app-mesh/latest/userguide/gateway-routes.html).
    pub fn createGatewayRoute(self: *Self, allocator: std.mem.Allocator, input: create_gateway_route.CreateGatewayRouteInput, options: CallOptions) !create_gateway_route.CreateGatewayRouteOutput {
        return create_gateway_route.execute(self, allocator, input, options);
    }

    /// Creates a service mesh.
    ///
    /// A service mesh is a logical boundary for network traffic between services
    /// that are
    /// represented by resources within the mesh. After you create your service
    /// mesh, you can
    /// create virtual services, virtual nodes, virtual routers, and routes to
    /// distribute traffic
    /// between the applications in your mesh.
    ///
    /// For more information about service meshes, see [Service
    /// meshes](https://docs.aws.amazon.com/app-mesh/latest/userguide/meshes.html).
    pub fn createMesh(self: *Self, allocator: std.mem.Allocator, input: create_mesh.CreateMeshInput, options: CallOptions) !create_mesh.CreateMeshOutput {
        return create_mesh.execute(self, allocator, input, options);
    }

    /// Creates a route that is associated with a virtual router.
    ///
    /// You can route several different protocols and define a retry policy for a
    /// route.
    /// Traffic can be routed to one or more virtual nodes.
    ///
    /// For more information about routes, see
    /// [Routes](https://docs.aws.amazon.com/app-mesh/latest/userguide/routes.html).
    pub fn createRoute(self: *Self, allocator: std.mem.Allocator, input: create_route.CreateRouteInput, options: CallOptions) !create_route.CreateRouteOutput {
        return create_route.execute(self, allocator, input, options);
    }

    /// Creates a virtual gateway.
    ///
    /// A virtual gateway allows resources outside your mesh to communicate to
    /// resources that
    /// are inside your mesh. The virtual gateway represents an Envoy proxy running
    /// in an Amazon ECS task, in a Kubernetes service, or on an Amazon EC2
    /// instance. Unlike a
    /// virtual node, which represents an Envoy running with an application, a
    /// virtual gateway
    /// represents Envoy deployed by itself.
    ///
    /// For more information about virtual gateways, see [Virtual
    /// gateways](https://docs.aws.amazon.com/app-mesh/latest/userguide/virtual_gateways.html).
    pub fn createVirtualGateway(self: *Self, allocator: std.mem.Allocator, input: create_virtual_gateway.CreateVirtualGatewayInput, options: CallOptions) !create_virtual_gateway.CreateVirtualGatewayOutput {
        return create_virtual_gateway.execute(self, allocator, input, options);
    }

    /// Creates a virtual node within a service mesh.
    ///
    /// A virtual node acts as a logical pointer to a particular task group, such as
    /// an Amazon ECS service or a Kubernetes deployment. When you create a virtual
    /// node, you can
    /// specify the service discovery information for your task group, and whether
    /// the proxy
    /// running in a task group will communicate with other proxies using Transport
    /// Layer Security
    /// (TLS).
    ///
    /// You define a `listener` for any inbound traffic that your virtual node
    /// expects. Any virtual service that your virtual node expects to communicate
    /// to is specified
    /// as a `backend`.
    ///
    /// The response metadata for your new virtual node contains the `arn` that is
    /// associated with the virtual node. Set this value to the full ARN; for
    /// example,
    /// `arn:aws:appmesh:us-west-2:123456789012:myMesh/default/virtualNode/myApp`)
    /// as the `APPMESH_RESOURCE_ARN` environment variable for your task group's
    /// Envoy
    /// proxy container in your task definition or pod spec. This is then mapped to
    /// the
    /// `node.id` and `node.cluster` Envoy parameters.
    ///
    /// By default, App Mesh uses the name of the resource you specified in
    /// `APPMESH_RESOURCE_ARN` when Envoy is referring to itself in metrics and
    /// traces. You can override this behavior by setting the
    /// `APPMESH_RESOURCE_CLUSTER` environment variable with your own name.
    ///
    /// For more information about virtual nodes, see [Virtual
    /// nodes](https://docs.aws.amazon.com/app-mesh/latest/userguide/virtual_nodes.html). You must be using `1.15.0` or later of the Envoy image when
    /// setting these variables. For more information aboutApp Mesh Envoy variables,
    /// see
    /// [Envoy
    /// image](https://docs.aws.amazon.com/app-mesh/latest/userguide/envoy.html) in
    /// the App Mesh User Guide.
    pub fn createVirtualNode(self: *Self, allocator: std.mem.Allocator, input: create_virtual_node.CreateVirtualNodeInput, options: CallOptions) !create_virtual_node.CreateVirtualNodeOutput {
        return create_virtual_node.execute(self, allocator, input, options);
    }

    /// Creates a virtual router within a service mesh.
    ///
    /// Specify a `listener` for any inbound traffic that your virtual router
    /// receives. Create a virtual router for each protocol and port that you need
    /// to route.
    /// Virtual routers handle traffic for one or more virtual services within your
    /// mesh. After you
    /// create your virtual router, create and associate routes for your virtual
    /// router that direct
    /// incoming requests to different virtual nodes.
    ///
    /// For more information about virtual routers, see [Virtual
    /// routers](https://docs.aws.amazon.com/app-mesh/latest/userguide/virtual_routers.html).
    pub fn createVirtualRouter(self: *Self, allocator: std.mem.Allocator, input: create_virtual_router.CreateVirtualRouterInput, options: CallOptions) !create_virtual_router.CreateVirtualRouterOutput {
        return create_virtual_router.execute(self, allocator, input, options);
    }

    /// Creates a virtual service within a service mesh.
    ///
    /// A virtual service is an abstraction of a real service that is provided by a
    /// virtual node
    /// directly or indirectly by means of a virtual router. Dependent services call
    /// your virtual
    /// service by its `virtualServiceName`, and those requests are routed to the
    /// virtual node or virtual router that is specified as the provider for the
    /// virtual
    /// service.
    ///
    /// For more information about virtual services, see [Virtual
    /// services](https://docs.aws.amazon.com/app-mesh/latest/userguide/virtual_services.html).
    pub fn createVirtualService(self: *Self, allocator: std.mem.Allocator, input: create_virtual_service.CreateVirtualServiceInput, options: CallOptions) !create_virtual_service.CreateVirtualServiceOutput {
        return create_virtual_service.execute(self, allocator, input, options);
    }

    /// Deletes an existing gateway route.
    pub fn deleteGatewayRoute(self: *Self, allocator: std.mem.Allocator, input: delete_gateway_route.DeleteGatewayRouteInput, options: CallOptions) !delete_gateway_route.DeleteGatewayRouteOutput {
        return delete_gateway_route.execute(self, allocator, input, options);
    }

    /// Deletes an existing service mesh.
    ///
    /// You must delete all resources (virtual services, routes, virtual routers,
    /// and virtual
    /// nodes) in the service mesh before you can delete the mesh itself.
    pub fn deleteMesh(self: *Self, allocator: std.mem.Allocator, input: delete_mesh.DeleteMeshInput, options: CallOptions) !delete_mesh.DeleteMeshOutput {
        return delete_mesh.execute(self, allocator, input, options);
    }

    /// Deletes an existing route.
    pub fn deleteRoute(self: *Self, allocator: std.mem.Allocator, input: delete_route.DeleteRouteInput, options: CallOptions) !delete_route.DeleteRouteOutput {
        return delete_route.execute(self, allocator, input, options);
    }

    /// Deletes an existing virtual gateway. You cannot delete a virtual gateway if
    /// any gateway
    /// routes are associated to it.
    pub fn deleteVirtualGateway(self: *Self, allocator: std.mem.Allocator, input: delete_virtual_gateway.DeleteVirtualGatewayInput, options: CallOptions) !delete_virtual_gateway.DeleteVirtualGatewayOutput {
        return delete_virtual_gateway.execute(self, allocator, input, options);
    }

    /// Deletes an existing virtual node.
    ///
    /// You must delete any virtual services that list a virtual node as a service
    /// provider
    /// before you can delete the virtual node itself.
    pub fn deleteVirtualNode(self: *Self, allocator: std.mem.Allocator, input: delete_virtual_node.DeleteVirtualNodeInput, options: CallOptions) !delete_virtual_node.DeleteVirtualNodeOutput {
        return delete_virtual_node.execute(self, allocator, input, options);
    }

    /// Deletes an existing virtual router.
    ///
    /// You must delete any routes associated with the virtual router before you can
    /// delete the
    /// router itself.
    pub fn deleteVirtualRouter(self: *Self, allocator: std.mem.Allocator, input: delete_virtual_router.DeleteVirtualRouterInput, options: CallOptions) !delete_virtual_router.DeleteVirtualRouterOutput {
        return delete_virtual_router.execute(self, allocator, input, options);
    }

    /// Deletes an existing virtual service.
    pub fn deleteVirtualService(self: *Self, allocator: std.mem.Allocator, input: delete_virtual_service.DeleteVirtualServiceInput, options: CallOptions) !delete_virtual_service.DeleteVirtualServiceOutput {
        return delete_virtual_service.execute(self, allocator, input, options);
    }

    /// Describes an existing gateway route.
    pub fn describeGatewayRoute(self: *Self, allocator: std.mem.Allocator, input: describe_gateway_route.DescribeGatewayRouteInput, options: CallOptions) !describe_gateway_route.DescribeGatewayRouteOutput {
        return describe_gateway_route.execute(self, allocator, input, options);
    }

    /// Describes an existing service mesh.
    pub fn describeMesh(self: *Self, allocator: std.mem.Allocator, input: describe_mesh.DescribeMeshInput, options: CallOptions) !describe_mesh.DescribeMeshOutput {
        return describe_mesh.execute(self, allocator, input, options);
    }

    /// Describes an existing route.
    pub fn describeRoute(self: *Self, allocator: std.mem.Allocator, input: describe_route.DescribeRouteInput, options: CallOptions) !describe_route.DescribeRouteOutput {
        return describe_route.execute(self, allocator, input, options);
    }

    /// Describes an existing virtual gateway.
    pub fn describeVirtualGateway(self: *Self, allocator: std.mem.Allocator, input: describe_virtual_gateway.DescribeVirtualGatewayInput, options: CallOptions) !describe_virtual_gateway.DescribeVirtualGatewayOutput {
        return describe_virtual_gateway.execute(self, allocator, input, options);
    }

    /// Describes an existing virtual node.
    pub fn describeVirtualNode(self: *Self, allocator: std.mem.Allocator, input: describe_virtual_node.DescribeVirtualNodeInput, options: CallOptions) !describe_virtual_node.DescribeVirtualNodeOutput {
        return describe_virtual_node.execute(self, allocator, input, options);
    }

    /// Describes an existing virtual router.
    pub fn describeVirtualRouter(self: *Self, allocator: std.mem.Allocator, input: describe_virtual_router.DescribeVirtualRouterInput, options: CallOptions) !describe_virtual_router.DescribeVirtualRouterOutput {
        return describe_virtual_router.execute(self, allocator, input, options);
    }

    /// Describes an existing virtual service.
    pub fn describeVirtualService(self: *Self, allocator: std.mem.Allocator, input: describe_virtual_service.DescribeVirtualServiceInput, options: CallOptions) !describe_virtual_service.DescribeVirtualServiceOutput {
        return describe_virtual_service.execute(self, allocator, input, options);
    }

    /// Returns a list of existing gateway routes that are associated to a virtual
    /// gateway.
    pub fn listGatewayRoutes(self: *Self, allocator: std.mem.Allocator, input: list_gateway_routes.ListGatewayRoutesInput, options: CallOptions) !list_gateway_routes.ListGatewayRoutesOutput {
        return list_gateway_routes.execute(self, allocator, input, options);
    }

    /// Returns a list of existing service meshes.
    pub fn listMeshes(self: *Self, allocator: std.mem.Allocator, input: list_meshes.ListMeshesInput, options: CallOptions) !list_meshes.ListMeshesOutput {
        return list_meshes.execute(self, allocator, input, options);
    }

    /// Returns a list of existing routes in a service mesh.
    pub fn listRoutes(self: *Self, allocator: std.mem.Allocator, input: list_routes.ListRoutesInput, options: CallOptions) !list_routes.ListRoutesOutput {
        return list_routes.execute(self, allocator, input, options);
    }

    /// List the tags for an App Mesh resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of existing virtual gateways in a service mesh.
    pub fn listVirtualGateways(self: *Self, allocator: std.mem.Allocator, input: list_virtual_gateways.ListVirtualGatewaysInput, options: CallOptions) !list_virtual_gateways.ListVirtualGatewaysOutput {
        return list_virtual_gateways.execute(self, allocator, input, options);
    }

    /// Returns a list of existing virtual nodes.
    pub fn listVirtualNodes(self: *Self, allocator: std.mem.Allocator, input: list_virtual_nodes.ListVirtualNodesInput, options: CallOptions) !list_virtual_nodes.ListVirtualNodesOutput {
        return list_virtual_nodes.execute(self, allocator, input, options);
    }

    /// Returns a list of existing virtual routers in a service mesh.
    pub fn listVirtualRouters(self: *Self, allocator: std.mem.Allocator, input: list_virtual_routers.ListVirtualRoutersInput, options: CallOptions) !list_virtual_routers.ListVirtualRoutersOutput {
        return list_virtual_routers.execute(self, allocator, input, options);
    }

    /// Returns a list of existing virtual services in a service mesh.
    pub fn listVirtualServices(self: *Self, allocator: std.mem.Allocator, input: list_virtual_services.ListVirtualServicesInput, options: CallOptions) !list_virtual_services.ListVirtualServicesOutput {
        return list_virtual_services.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to a resource with the specified
    /// `resourceArn`.
    /// If existing tags on a resource aren't specified in the request parameters,
    /// they aren't
    /// changed. When a resource is deleted, the tags associated with that resource
    /// are also
    /// deleted.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing gateway route that is associated to a specified virtual
    /// gateway in a
    /// service mesh.
    pub fn updateGatewayRoute(self: *Self, allocator: std.mem.Allocator, input: update_gateway_route.UpdateGatewayRouteInput, options: CallOptions) !update_gateway_route.UpdateGatewayRouteOutput {
        return update_gateway_route.execute(self, allocator, input, options);
    }

    /// Updates an existing service mesh.
    pub fn updateMesh(self: *Self, allocator: std.mem.Allocator, input: update_mesh.UpdateMeshInput, options: CallOptions) !update_mesh.UpdateMeshOutput {
        return update_mesh.execute(self, allocator, input, options);
    }

    /// Updates an existing route for a specified service mesh and virtual router.
    pub fn updateRoute(self: *Self, allocator: std.mem.Allocator, input: update_route.UpdateRouteInput, options: CallOptions) !update_route.UpdateRouteOutput {
        return update_route.execute(self, allocator, input, options);
    }

    /// Updates an existing virtual gateway in a specified service mesh.
    pub fn updateVirtualGateway(self: *Self, allocator: std.mem.Allocator, input: update_virtual_gateway.UpdateVirtualGatewayInput, options: CallOptions) !update_virtual_gateway.UpdateVirtualGatewayOutput {
        return update_virtual_gateway.execute(self, allocator, input, options);
    }

    /// Updates an existing virtual node in a specified service mesh.
    pub fn updateVirtualNode(self: *Self, allocator: std.mem.Allocator, input: update_virtual_node.UpdateVirtualNodeInput, options: CallOptions) !update_virtual_node.UpdateVirtualNodeOutput {
        return update_virtual_node.execute(self, allocator, input, options);
    }

    /// Updates an existing virtual router in a specified service mesh.
    pub fn updateVirtualRouter(self: *Self, allocator: std.mem.Allocator, input: update_virtual_router.UpdateVirtualRouterInput, options: CallOptions) !update_virtual_router.UpdateVirtualRouterOutput {
        return update_virtual_router.execute(self, allocator, input, options);
    }

    /// Updates an existing virtual service in a specified service mesh.
    pub fn updateVirtualService(self: *Self, allocator: std.mem.Allocator, input: update_virtual_service.UpdateVirtualServiceInput, options: CallOptions) !update_virtual_service.UpdateVirtualServiceOutput {
        return update_virtual_service.execute(self, allocator, input, options);
    }

    pub fn listGatewayRoutesPaginator(self: *Self, params: list_gateway_routes.ListGatewayRoutesInput) paginator.ListGatewayRoutesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMeshesPaginator(self: *Self, params: list_meshes.ListMeshesInput) paginator.ListMeshesPaginator {
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

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVirtualGatewaysPaginator(self: *Self, params: list_virtual_gateways.ListVirtualGatewaysInput) paginator.ListVirtualGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVirtualNodesPaginator(self: *Self, params: list_virtual_nodes.ListVirtualNodesInput) paginator.ListVirtualNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVirtualRoutersPaginator(self: *Self, params: list_virtual_routers.ListVirtualRoutersInput) paginator.ListVirtualRoutersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVirtualServicesPaginator(self: *Self, params: list_virtual_services.ListVirtualServicesInput) paginator.ListVirtualServicesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
