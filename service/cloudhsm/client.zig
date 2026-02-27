const aws = @import("aws");
const std = @import("std");

const add_tags_to_resource = @import("add_tags_to_resource.zig");
const create_hapg = @import("create_hapg.zig");
const create_hsm = @import("create_hsm.zig");
const create_luna_client = @import("create_luna_client.zig");
const delete_hapg = @import("delete_hapg.zig");
const delete_hsm = @import("delete_hsm.zig");
const delete_luna_client = @import("delete_luna_client.zig");
const describe_hapg = @import("describe_hapg.zig");
const describe_hsm = @import("describe_hsm.zig");
const describe_luna_client = @import("describe_luna_client.zig");
const get_config = @import("get_config.zig");
const list_available_zones = @import("list_available_zones.zig");
const list_hapgs = @import("list_hapgs.zig");
const list_hsms = @import("list_hsms.zig");
const list_luna_clients = @import("list_luna_clients.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const modify_hapg = @import("modify_hapg.zig");
const modify_hsm = @import("modify_hsm.zig");
const modify_luna_client = @import("modify_luna_client.zig");
const remove_tags_from_resource = @import("remove_tags_from_resource.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudHSM";

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

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Adds or overwrites one or more tags for the specified AWS CloudHSM resource.
    ///
    /// Each tag consists of a key and a value. Tag keys must be unique to each
    /// resource.
    pub fn addTagsToResource(self: *Self, allocator: std.mem.Allocator, input: add_tags_to_resource.AddTagsToResourceInput, options: add_tags_to_resource.Options) !add_tags_to_resource.AddTagsToResourceOutput {
        return add_tags_to_resource.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Creates a high-availability partition group. A high-availability partition
    /// group is a
    /// group of partitions that spans multiple physical HSMs.
    pub fn createHapg(self: *Self, allocator: std.mem.Allocator, input: create_hapg.CreateHapgInput, options: create_hapg.Options) !create_hapg.CreateHapgOutput {
        return create_hapg.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Creates an uninitialized HSM instance.
    ///
    /// There is an upfront fee charged for each HSM instance that you create with
    /// the
    /// `CreateHsm` operation. If you accidentally provision an HSM and want to
    /// request a
    /// refund, delete the instance using the DeleteHsm operation, go to the [AWS
    /// Support Center](https://console.aws.amazon.com/support/home), create a new
    /// case, and select
    /// **Account and Billing Support**.
    ///
    /// It can take up to 20 minutes to create and provision an HSM. You can monitor
    /// the
    /// status of the HSM with the DescribeHsm operation. The HSM is ready to be
    /// initialized when the status changes to `RUNNING`.
    pub fn createHsm(self: *Self, allocator: std.mem.Allocator, input: create_hsm.CreateHsmInput, options: create_hsm.Options) !create_hsm.CreateHsmOutput {
        return create_hsm.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Creates an HSM client.
    pub fn createLunaClient(self: *Self, allocator: std.mem.Allocator, input: create_luna_client.CreateLunaClientInput, options: create_luna_client.Options) !create_luna_client.CreateLunaClientOutput {
        return create_luna_client.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Deletes a high-availability partition group.
    pub fn deleteHapg(self: *Self, allocator: std.mem.Allocator, input: delete_hapg.DeleteHapgInput, options: delete_hapg.Options) !delete_hapg.DeleteHapgOutput {
        return delete_hapg.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Deletes an HSM. After completion, this operation cannot be undone and your
    /// key material
    /// cannot be recovered.
    pub fn deleteHsm(self: *Self, allocator: std.mem.Allocator, input: delete_hsm.DeleteHsmInput, options: delete_hsm.Options) !delete_hsm.DeleteHsmOutput {
        return delete_hsm.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Deletes a client.
    pub fn deleteLunaClient(self: *Self, allocator: std.mem.Allocator, input: delete_luna_client.DeleteLunaClientInput, options: delete_luna_client.Options) !delete_luna_client.DeleteLunaClientOutput {
        return delete_luna_client.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Retrieves information about a high-availability partition group.
    pub fn describeHapg(self: *Self, allocator: std.mem.Allocator, input: describe_hapg.DescribeHapgInput, options: describe_hapg.Options) !describe_hapg.DescribeHapgOutput {
        return describe_hapg.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Retrieves information about an HSM. You can identify the HSM by its ARN or
    /// its serial
    /// number.
    pub fn describeHsm(self: *Self, allocator: std.mem.Allocator, input: describe_hsm.DescribeHsmInput, options: describe_hsm.Options) !describe_hsm.DescribeHsmOutput {
        return describe_hsm.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Retrieves information about an HSM client.
    pub fn describeLunaClient(self: *Self, allocator: std.mem.Allocator, input: describe_luna_client.DescribeLunaClientInput, options: describe_luna_client.Options) !describe_luna_client.DescribeLunaClientOutput {
        return describe_luna_client.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Gets the configuration files necessary to connect to all high availability
    /// partition
    /// groups the client is associated with.
    pub fn getConfig(self: *Self, allocator: std.mem.Allocator, input: get_config.GetConfigInput, options: get_config.Options) !get_config.GetConfigOutput {
        return get_config.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Lists the Availability Zones that have available AWS CloudHSM capacity.
    pub fn listAvailableZones(self: *Self, allocator: std.mem.Allocator, input: list_available_zones.ListAvailableZonesInput, options: list_available_zones.Options) !list_available_zones.ListAvailableZonesOutput {
        return list_available_zones.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Lists the high-availability partition groups for the account.
    ///
    /// This operation supports pagination with the use of the `NextToken` member.
    /// If more results are available, the `NextToken` member of the response
    /// contains a
    /// token that you pass in the next call to `ListHapgs` to retrieve the next set
    /// of
    /// items.
    pub fn listHapgs(self: *Self, allocator: std.mem.Allocator, input: list_hapgs.ListHapgsInput, options: list_hapgs.Options) !list_hapgs.ListHapgsOutput {
        return list_hapgs.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Retrieves the identifiers of all of the HSMs provisioned for the current
    /// customer.
    ///
    /// This operation supports pagination with the use of the `NextToken` member.
    /// If more results are available, the `NextToken` member of the response
    /// contains a
    /// token that you pass in the next call to `ListHsms` to retrieve the next set
    /// of
    /// items.
    pub fn listHsms(self: *Self, allocator: std.mem.Allocator, input: list_hsms.ListHsmsInput, options: list_hsms.Options) !list_hsms.ListHsmsOutput {
        return list_hsms.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Lists all of the clients.
    ///
    /// This operation supports pagination with the use of the `NextToken` member.
    /// If more results are available, the `NextToken` member of the response
    /// contains a
    /// token that you pass in the next call to `ListLunaClients` to retrieve the
    /// next set
    /// of items.
    pub fn listLunaClients(self: *Self, allocator: std.mem.Allocator, input: list_luna_clients.ListLunaClientsInput, options: list_luna_clients.Options) !list_luna_clients.ListLunaClientsOutput {
        return list_luna_clients.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Returns a list of all tags for the specified AWS CloudHSM resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Modifies an existing high-availability partition group.
    pub fn modifyHapg(self: *Self, allocator: std.mem.Allocator, input: modify_hapg.ModifyHapgInput, options: modify_hapg.Options) !modify_hapg.ModifyHapgOutput {
        return modify_hapg.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Modifies an HSM.
    ///
    /// This operation can result in the HSM being offline for up to 15 minutes
    /// while the AWS
    /// CloudHSM service is reconfigured. If you are modifying a production HSM, you
    /// should ensure
    /// that your AWS CloudHSM service is configured for high availability, and
    /// consider executing this
    /// operation during a maintenance window.
    pub fn modifyHsm(self: *Self, allocator: std.mem.Allocator, input: modify_hsm.ModifyHsmInput, options: modify_hsm.Options) !modify_hsm.ModifyHsmOutput {
        return modify_hsm.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Modifies the certificate used by the client.
    ///
    /// This action can potentially start a workflow to install the new certificate
    /// on the
    /// client's HSMs.
    pub fn modifyLunaClient(self: *Self, allocator: std.mem.Allocator, input: modify_luna_client.ModifyLunaClientInput, options: modify_luna_client.Options) !modify_luna_client.ModifyLunaClientOutput {
        return modify_luna_client.execute(self, allocator, input, options);
    }

    /// This is documentation for **AWS CloudHSM Classic**. For
    /// more information, see [AWS CloudHSM
    /// Classic FAQs](http://aws.amazon.com/cloudhsm/faqs-classic/), the [AWS
    /// CloudHSM Classic User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/classic/userguide/), and the
    /// [AWS CloudHSM Classic API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/classic/APIReference/).
    ///
    /// **For information about the current version of AWS
    /// CloudHSM**, see [AWS CloudHSM](http://aws.amazon.com/cloudhsm/), the
    /// [AWS CloudHSM User
    /// Guide](https://docs.aws.amazon.com/cloudhsm/latest/userguide/),
    /// and the [AWS CloudHSM API
    /// Reference](https://docs.aws.amazon.com/cloudhsm/latest/APIReference/).
    ///
    /// Removes one or more tags from the specified AWS CloudHSM resource.
    ///
    /// To remove a tag, specify only the tag key to remove (not the value). To
    /// overwrite the
    /// value for an existing tag, use AddTagsToResource.
    pub fn removeTagsFromResource(self: *Self, allocator: std.mem.Allocator, input: remove_tags_from_resource.RemoveTagsFromResourceInput, options: remove_tags_from_resource.Options) !remove_tags_from_resource.RemoveTagsFromResourceOutput {
        return remove_tags_from_resource.execute(self, allocator, input, options);
    }
};
