const aws = @import("aws");
const std = @import("std");

const cancel_sol_network_operation = @import("cancel_sol_network_operation.zig");
const create_sol_function_package = @import("create_sol_function_package.zig");
const create_sol_network_instance = @import("create_sol_network_instance.zig");
const create_sol_network_package = @import("create_sol_network_package.zig");
const delete_sol_function_package = @import("delete_sol_function_package.zig");
const delete_sol_network_instance = @import("delete_sol_network_instance.zig");
const delete_sol_network_package = @import("delete_sol_network_package.zig");
const get_sol_function_instance = @import("get_sol_function_instance.zig");
const get_sol_function_package = @import("get_sol_function_package.zig");
const get_sol_function_package_content = @import("get_sol_function_package_content.zig");
const get_sol_function_package_descriptor = @import("get_sol_function_package_descriptor.zig");
const get_sol_network_instance = @import("get_sol_network_instance.zig");
const get_sol_network_operation = @import("get_sol_network_operation.zig");
const get_sol_network_package = @import("get_sol_network_package.zig");
const get_sol_network_package_content = @import("get_sol_network_package_content.zig");
const get_sol_network_package_descriptor = @import("get_sol_network_package_descriptor.zig");
const instantiate_sol_network_instance = @import("instantiate_sol_network_instance.zig");
const list_sol_function_instances = @import("list_sol_function_instances.zig");
const list_sol_function_packages = @import("list_sol_function_packages.zig");
const list_sol_network_instances = @import("list_sol_network_instances.zig");
const list_sol_network_operations = @import("list_sol_network_operations.zig");
const list_sol_network_packages = @import("list_sol_network_packages.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_sol_function_package_content = @import("put_sol_function_package_content.zig");
const put_sol_network_package_content = @import("put_sol_network_package_content.zig");
const tag_resource = @import("tag_resource.zig");
const terminate_sol_network_instance = @import("terminate_sol_network_instance.zig");
const untag_resource = @import("untag_resource.zig");
const update_sol_function_package = @import("update_sol_function_package.zig");
const update_sol_network_instance = @import("update_sol_network_instance.zig");
const update_sol_network_package = @import("update_sol_network_package.zig");
const validate_sol_function_package_content = @import("validate_sol_function_package_content.zig");
const validate_sol_network_package_content = @import("validate_sol_network_package_content.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "tnb";

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

    /// Cancels a network operation.
    ///
    /// A network operation is any operation that is done to your network, such as
    /// network instance instantiation or termination.
    pub fn cancelSolNetworkOperation(self: *Self, allocator: std.mem.Allocator, input: cancel_sol_network_operation.CancelSolNetworkOperationInput, options: CallOptions) !cancel_sol_network_operation.CancelSolNetworkOperationOutput {
        return cancel_sol_network_operation.execute(self, allocator, input, options);
    }

    /// Creates a function package.
    ///
    /// A function package is a .zip file in CSAR (Cloud Service Archive) format
    /// that contains a network function (an ETSI standard telecommunication
    /// application) and function package descriptor that uses the TOSCA standard to
    /// describe how the network functions should run on your network. For more
    /// information, see [Function
    /// packages](https://docs.aws.amazon.com/tnb/latest/ug/function-packages.html)
    /// in the
    /// *Amazon Web Services Telco Network Builder User Guide*.
    ///
    /// Creating a function package is the first step for creating a network in AWS
    /// TNB. This
    /// request creates an empty container with an ID. The next step is to upload
    /// the actual CSAR
    /// zip file into that empty container. To upload function package content, see
    /// [PutSolFunctionPackageContent](https://docs.aws.amazon.com/tnb/latest/APIReference/API_PutSolFunctionPackageContent.html).
    pub fn createSolFunctionPackage(self: *Self, allocator: std.mem.Allocator, input: create_sol_function_package.CreateSolFunctionPackageInput, options: CallOptions) !create_sol_function_package.CreateSolFunctionPackageOutput {
        return create_sol_function_package.execute(self, allocator, input, options);
    }

    /// Creates a network instance.
    ///
    /// A network instance is a single network created in Amazon Web Services TNB
    /// that can be deployed and on which life-cycle operations (like terminate,
    /// update, and delete) can be performed. Creating a network instance is the
    /// third step after creating a network
    /// package. For more information about network instances, [Network
    /// instances](https://docs.aws.amazon.com/tnb/latest/ug/network-instances.html)
    /// in the
    /// *Amazon Web Services Telco Network Builder User Guide*.
    ///
    /// Once you create a network instance, you can instantiate it. To instantiate a
    /// network,
    /// see
    /// [InstantiateSolNetworkInstance](https://docs.aws.amazon.com/tnb/latest/APIReference/API_InstantiateSolNetworkInstance.html).
    pub fn createSolNetworkInstance(self: *Self, allocator: std.mem.Allocator, input: create_sol_network_instance.CreateSolNetworkInstanceInput, options: CallOptions) !create_sol_network_instance.CreateSolNetworkInstanceOutput {
        return create_sol_network_instance.execute(self, allocator, input, options);
    }

    /// Creates a network package.
    ///
    /// A network package is a .zip file in CSAR (Cloud Service Archive) format
    /// defines the function packages you want to deploy and the Amazon Web Services
    /// infrastructure you want to deploy them on. For more information, see
    /// [Network
    /// instances](https://docs.aws.amazon.com/tnb/latest/ug/network-instances.html)
    /// in the
    /// *Amazon Web Services Telco Network Builder User Guide*.
    ///
    /// A network package consists of a network service descriptor (NSD) file
    /// (required) and any
    /// additional files (optional), such as scripts specific to your needs. For
    /// example, if you
    /// have multiple function packages in your network package, you can use the NSD
    /// to define
    /// which network functions should run in certain VPCs, subnets, or EKS
    /// clusters.
    ///
    /// This request creates an empty network package container with an ID. Once you
    /// create a
    /// network package, you can upload the network package content using
    /// [PutSolNetworkPackageContent](https://docs.aws.amazon.com/tnb/latest/APIReference/API_PutSolNetworkPackageContent.html).
    pub fn createSolNetworkPackage(self: *Self, allocator: std.mem.Allocator, input: create_sol_network_package.CreateSolNetworkPackageInput, options: CallOptions) !create_sol_network_package.CreateSolNetworkPackageOutput {
        return create_sol_network_package.execute(self, allocator, input, options);
    }

    /// Deletes a function package.
    ///
    /// A function package is a .zip file in CSAR (Cloud Service Archive) format
    /// that contains a network function (an ETSI standard telecommunication
    /// application) and function package descriptor that uses the TOSCA standard to
    /// describe how the network functions should run on your network.
    ///
    /// To delete a function package, the package must be in a disabled state. To
    /// disable a
    /// function package, see
    /// [UpdateSolFunctionPackage](https://docs.aws.amazon.com/tnb/latest/APIReference/API_UpdateSolFunctionPackage.html).
    pub fn deleteSolFunctionPackage(self: *Self, allocator: std.mem.Allocator, input: delete_sol_function_package.DeleteSolFunctionPackageInput, options: CallOptions) !delete_sol_function_package.DeleteSolFunctionPackageOutput {
        return delete_sol_function_package.execute(self, allocator, input, options);
    }

    /// Deletes a network instance.
    ///
    /// A network instance is a single network created in Amazon Web Services TNB
    /// that can be deployed and on which life-cycle operations (like terminate,
    /// update, and delete) can be performed.
    ///
    /// To delete a network instance, the instance must be in a stopped or
    /// terminated state. To
    /// terminate a network instance, see
    /// [TerminateSolNetworkInstance](https://docs.aws.amazon.com/tnb/latest/APIReference/API_TerminateSolNetworkInstance.html).
    pub fn deleteSolNetworkInstance(self: *Self, allocator: std.mem.Allocator, input: delete_sol_network_instance.DeleteSolNetworkInstanceInput, options: CallOptions) !delete_sol_network_instance.DeleteSolNetworkInstanceOutput {
        return delete_sol_network_instance.execute(self, allocator, input, options);
    }

    /// Deletes network package.
    ///
    /// A network package is a .zip file in CSAR (Cloud Service Archive) format
    /// defines the function packages you want to deploy and the Amazon Web Services
    /// infrastructure you want to deploy them on.
    ///
    /// To delete a network package, the package must be in a disable state. To
    /// disable a
    /// network package, see
    /// [UpdateSolNetworkPackage](https://docs.aws.amazon.com/tnb/latest/APIReference/API_UpdateSolNetworkPackage.html).
    pub fn deleteSolNetworkPackage(self: *Self, allocator: std.mem.Allocator, input: delete_sol_network_package.DeleteSolNetworkPackageInput, options: CallOptions) !delete_sol_network_package.DeleteSolNetworkPackageOutput {
        return delete_sol_network_package.execute(self, allocator, input, options);
    }

    /// Gets the details of a network function instance, including the instantiation
    /// state and
    /// metadata from the function package descriptor in the network function
    /// package.
    ///
    /// A network function instance is a function in a function package .
    pub fn getSolFunctionInstance(self: *Self, allocator: std.mem.Allocator, input: get_sol_function_instance.GetSolFunctionInstanceInput, options: CallOptions) !get_sol_function_instance.GetSolFunctionInstanceOutput {
        return get_sol_function_instance.execute(self, allocator, input, options);
    }

    /// Gets the details of an individual function package, such as the operational
    /// state and
    /// whether the package is in use.
    ///
    /// A function package is a .zip file in CSAR (Cloud Service Archive) format
    /// that contains a network function (an ETSI standard telecommunication
    /// application) and function package descriptor that uses the TOSCA standard to
    /// describe how the network functions should run on your network..
    pub fn getSolFunctionPackage(self: *Self, allocator: std.mem.Allocator, input: get_sol_function_package.GetSolFunctionPackageInput, options: CallOptions) !get_sol_function_package.GetSolFunctionPackageOutput {
        return get_sol_function_package.execute(self, allocator, input, options);
    }

    /// Gets the contents of a function package.
    ///
    /// A function package is a .zip file in CSAR (Cloud Service Archive) format
    /// that contains a network function (an ETSI standard telecommunication
    /// application) and function package descriptor that uses the TOSCA standard to
    /// describe how the network functions should run on your network.
    pub fn getSolFunctionPackageContent(self: *Self, allocator: std.mem.Allocator, input: get_sol_function_package_content.GetSolFunctionPackageContentInput, options: CallOptions) !get_sol_function_package_content.GetSolFunctionPackageContentOutput {
        return get_sol_function_package_content.execute(self, allocator, input, options);
    }

    /// Gets a function package descriptor in a function package.
    ///
    /// A function package descriptor is a .yaml file in a function package that
    /// uses the TOSCA standard to describe how the network function in the function
    /// package should run on your network.
    ///
    /// A function package is a .zip file in CSAR (Cloud Service Archive) format
    /// that contains a network function (an ETSI standard telecommunication
    /// application) and function package descriptor that uses the TOSCA standard to
    /// describe how the network functions should run on your network.
    pub fn getSolFunctionPackageDescriptor(self: *Self, allocator: std.mem.Allocator, input: get_sol_function_package_descriptor.GetSolFunctionPackageDescriptorInput, options: CallOptions) !get_sol_function_package_descriptor.GetSolFunctionPackageDescriptorOutput {
        return get_sol_function_package_descriptor.execute(self, allocator, input, options);
    }

    /// Gets the details of the network instance.
    ///
    /// A network instance is a single network created in Amazon Web Services TNB
    /// that can be deployed and on which life-cycle operations (like terminate,
    /// update, and delete) can be performed.
    pub fn getSolNetworkInstance(self: *Self, allocator: std.mem.Allocator, input: get_sol_network_instance.GetSolNetworkInstanceInput, options: CallOptions) !get_sol_network_instance.GetSolNetworkInstanceOutput {
        return get_sol_network_instance.execute(self, allocator, input, options);
    }

    /// Gets the details of a network operation, including the tasks involved in the
    /// network
    /// operation and the status of the tasks.
    ///
    /// A network operation is any operation that is done to your network, such as
    /// network instance instantiation or termination.
    pub fn getSolNetworkOperation(self: *Self, allocator: std.mem.Allocator, input: get_sol_network_operation.GetSolNetworkOperationInput, options: CallOptions) !get_sol_network_operation.GetSolNetworkOperationOutput {
        return get_sol_network_operation.execute(self, allocator, input, options);
    }

    /// Gets the details of a network package.
    ///
    /// A network package is a .zip file in CSAR (Cloud Service Archive) format
    /// defines the function packages you want to deploy and the Amazon Web Services
    /// infrastructure you want to deploy them on.
    pub fn getSolNetworkPackage(self: *Self, allocator: std.mem.Allocator, input: get_sol_network_package.GetSolNetworkPackageInput, options: CallOptions) !get_sol_network_package.GetSolNetworkPackageOutput {
        return get_sol_network_package.execute(self, allocator, input, options);
    }

    /// Gets the contents of a network package.
    ///
    /// A network package is a .zip file in CSAR (Cloud Service Archive) format
    /// defines the function packages you want to deploy and the Amazon Web Services
    /// infrastructure you want to deploy them on.
    pub fn getSolNetworkPackageContent(self: *Self, allocator: std.mem.Allocator, input: get_sol_network_package_content.GetSolNetworkPackageContentInput, options: CallOptions) !get_sol_network_package_content.GetSolNetworkPackageContentOutput {
        return get_sol_network_package_content.execute(self, allocator, input, options);
    }

    /// Gets the content of the network service descriptor.
    ///
    /// A network service descriptor is a .yaml file in a network package that uses
    /// the TOSCA standard to describe the network functions you want to deploy and
    /// the Amazon Web Services infrastructure you want to deploy the network
    /// functions on.
    pub fn getSolNetworkPackageDescriptor(self: *Self, allocator: std.mem.Allocator, input: get_sol_network_package_descriptor.GetSolNetworkPackageDescriptorInput, options: CallOptions) !get_sol_network_package_descriptor.GetSolNetworkPackageDescriptorOutput {
        return get_sol_network_package_descriptor.execute(self, allocator, input, options);
    }

    /// Instantiates a network instance.
    ///
    /// A network instance is a single network created in Amazon Web Services TNB
    /// that can be deployed and on which life-cycle operations (like terminate,
    /// update, and delete) can be performed.
    ///
    /// Before you can instantiate a network instance, you have to create a network
    /// instance.
    /// For more information, see
    /// [CreateSolNetworkInstance](https://docs.aws.amazon.com/tnb/latest/APIReference/API_CreateSolNetworkInstance.html).
    pub fn instantiateSolNetworkInstance(self: *Self, allocator: std.mem.Allocator, input: instantiate_sol_network_instance.InstantiateSolNetworkInstanceInput, options: CallOptions) !instantiate_sol_network_instance.InstantiateSolNetworkInstanceOutput {
        return instantiate_sol_network_instance.execute(self, allocator, input, options);
    }

    /// Lists network function instances.
    ///
    /// A network function instance is a function in a function package .
    pub fn listSolFunctionInstances(self: *Self, allocator: std.mem.Allocator, input: list_sol_function_instances.ListSolFunctionInstancesInput, options: CallOptions) !list_sol_function_instances.ListSolFunctionInstancesOutput {
        return list_sol_function_instances.execute(self, allocator, input, options);
    }

    /// Lists information about function packages.
    ///
    /// A function package is a .zip file in CSAR (Cloud Service Archive) format
    /// that contains a network function (an ETSI standard telecommunication
    /// application) and function package descriptor that uses the TOSCA standard to
    /// describe how the network functions should run on your network.
    pub fn listSolFunctionPackages(self: *Self, allocator: std.mem.Allocator, input: list_sol_function_packages.ListSolFunctionPackagesInput, options: CallOptions) !list_sol_function_packages.ListSolFunctionPackagesOutput {
        return list_sol_function_packages.execute(self, allocator, input, options);
    }

    /// Lists your network instances.
    ///
    /// A network instance is a single network created in Amazon Web Services TNB
    /// that can be deployed and on which life-cycle operations (like terminate,
    /// update, and delete) can be performed.
    pub fn listSolNetworkInstances(self: *Self, allocator: std.mem.Allocator, input: list_sol_network_instances.ListSolNetworkInstancesInput, options: CallOptions) !list_sol_network_instances.ListSolNetworkInstancesOutput {
        return list_sol_network_instances.execute(self, allocator, input, options);
    }

    /// Lists details for a network operation, including when the operation started
    /// and the
    /// status of the operation.
    ///
    /// A network operation is any operation that is done to your network, such as
    /// network instance instantiation or termination.
    pub fn listSolNetworkOperations(self: *Self, allocator: std.mem.Allocator, input: list_sol_network_operations.ListSolNetworkOperationsInput, options: CallOptions) !list_sol_network_operations.ListSolNetworkOperationsOutput {
        return list_sol_network_operations.execute(self, allocator, input, options);
    }

    /// Lists network packages.
    ///
    /// A network package is a .zip file in CSAR (Cloud Service Archive) format
    /// defines the function packages you want to deploy and the Amazon Web Services
    /// infrastructure you want to deploy them on.
    pub fn listSolNetworkPackages(self: *Self, allocator: std.mem.Allocator, input: list_sol_network_packages.ListSolNetworkPackagesInput, options: CallOptions) !list_sol_network_packages.ListSolNetworkPackagesOutput {
        return list_sol_network_packages.execute(self, allocator, input, options);
    }

    /// Lists tags for AWS TNB resources.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Uploads the contents of a function package.
    ///
    /// A function package is a .zip file in CSAR (Cloud Service Archive) format
    /// that contains a network function (an ETSI standard telecommunication
    /// application) and function package descriptor that uses the TOSCA standard to
    /// describe how the network functions should run on your network.
    pub fn putSolFunctionPackageContent(self: *Self, allocator: std.mem.Allocator, input: put_sol_function_package_content.PutSolFunctionPackageContentInput, options: CallOptions) !put_sol_function_package_content.PutSolFunctionPackageContentOutput {
        return put_sol_function_package_content.execute(self, allocator, input, options);
    }

    /// Uploads the contents of a network package.
    ///
    /// A network package is a .zip file in CSAR (Cloud Service Archive) format
    /// defines the function packages you want to deploy and the Amazon Web Services
    /// infrastructure you want to deploy them on.
    pub fn putSolNetworkPackageContent(self: *Self, allocator: std.mem.Allocator, input: put_sol_network_package_content.PutSolNetworkPackageContentInput, options: CallOptions) !put_sol_network_package_content.PutSolNetworkPackageContentOutput {
        return put_sol_network_package_content.execute(self, allocator, input, options);
    }

    /// Tags an AWS TNB resource.
    ///
    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Terminates a network instance.
    ///
    /// A network instance is a single network created in Amazon Web Services TNB
    /// that can be deployed and on which life-cycle operations (like terminate,
    /// update, and delete) can be performed.
    ///
    /// You must terminate a network instance before you can delete it.
    pub fn terminateSolNetworkInstance(self: *Self, allocator: std.mem.Allocator, input: terminate_sol_network_instance.TerminateSolNetworkInstanceInput, options: CallOptions) !terminate_sol_network_instance.TerminateSolNetworkInstanceOutput {
        return terminate_sol_network_instance.execute(self, allocator, input, options);
    }

    /// Untags an AWS TNB resource.
    ///
    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the operational state of function package.
    ///
    /// A function package is a .zip file in CSAR (Cloud Service Archive) format
    /// that contains a network function (an ETSI standard telecommunication
    /// application) and function package descriptor that uses the TOSCA standard to
    /// describe how the network functions should run on your network.
    pub fn updateSolFunctionPackage(self: *Self, allocator: std.mem.Allocator, input: update_sol_function_package.UpdateSolFunctionPackageInput, options: CallOptions) !update_sol_function_package.UpdateSolFunctionPackageOutput {
        return update_sol_function_package.execute(self, allocator, input, options);
    }

    /// Update a network instance.
    ///
    /// A network instance is a single network created in Amazon Web Services TNB
    /// that can be deployed and on which life-cycle operations (like terminate,
    /// update, and delete) can be performed.
    ///
    /// Choose the *updateType* parameter to target the necessary update of the
    /// network instance.
    pub fn updateSolNetworkInstance(self: *Self, allocator: std.mem.Allocator, input: update_sol_network_instance.UpdateSolNetworkInstanceInput, options: CallOptions) !update_sol_network_instance.UpdateSolNetworkInstanceOutput {
        return update_sol_network_instance.execute(self, allocator, input, options);
    }

    /// Updates the operational state of a network package.
    ///
    /// A network package is a .zip file in CSAR (Cloud Service Archive) format
    /// defines the function packages you want to deploy and the Amazon Web Services
    /// infrastructure you want to deploy them on.
    ///
    /// A network service descriptor is a .yaml file in a network package that uses
    /// the TOSCA standard to describe the network functions you want to deploy and
    /// the Amazon Web Services infrastructure you want to deploy the network
    /// functions on.
    pub fn updateSolNetworkPackage(self: *Self, allocator: std.mem.Allocator, input: update_sol_network_package.UpdateSolNetworkPackageInput, options: CallOptions) !update_sol_network_package.UpdateSolNetworkPackageOutput {
        return update_sol_network_package.execute(self, allocator, input, options);
    }

    /// Validates function package content. This can be used as a dry run before
    /// uploading
    /// function package content with
    /// [PutSolFunctionPackageContent](https://docs.aws.amazon.com/tnb/latest/APIReference/API_PutSolFunctionPackageContent.html).
    ///
    /// A function package is a .zip file in CSAR (Cloud Service Archive) format
    /// that contains a network function (an ETSI standard telecommunication
    /// application) and function package descriptor that uses the TOSCA standard to
    /// describe how the network functions should run on your network.
    pub fn validateSolFunctionPackageContent(self: *Self, allocator: std.mem.Allocator, input: validate_sol_function_package_content.ValidateSolFunctionPackageContentInput, options: CallOptions) !validate_sol_function_package_content.ValidateSolFunctionPackageContentOutput {
        return validate_sol_function_package_content.execute(self, allocator, input, options);
    }

    /// Validates network package content. This can be used as a dry run before
    /// uploading
    /// network package content with
    /// [PutSolNetworkPackageContent](https://docs.aws.amazon.com/tnb/latest/APIReference/API_PutSolNetworkPackageContent.html).
    ///
    /// A network package is a .zip file in CSAR (Cloud Service Archive) format
    /// defines the function packages you want to deploy and the Amazon Web Services
    /// infrastructure you want to deploy them on.
    pub fn validateSolNetworkPackageContent(self: *Self, allocator: std.mem.Allocator, input: validate_sol_network_package_content.ValidateSolNetworkPackageContentInput, options: CallOptions) !validate_sol_network_package_content.ValidateSolNetworkPackageContentOutput {
        return validate_sol_network_package_content.execute(self, allocator, input, options);
    }

    pub fn listSolFunctionInstancesPaginator(self: *Self, params: list_sol_function_instances.ListSolFunctionInstancesInput) paginator.ListSolFunctionInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSolFunctionPackagesPaginator(self: *Self, params: list_sol_function_packages.ListSolFunctionPackagesInput) paginator.ListSolFunctionPackagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSolNetworkInstancesPaginator(self: *Self, params: list_sol_network_instances.ListSolNetworkInstancesInput) paginator.ListSolNetworkInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSolNetworkOperationsPaginator(self: *Self, params: list_sol_network_operations.ListSolNetworkOperationsInput) paginator.ListSolNetworkOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSolNetworkPackagesPaginator(self: *Self, params: list_sol_network_packages.ListSolNetworkPackagesInput) paginator.ListSolNetworkPackagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
