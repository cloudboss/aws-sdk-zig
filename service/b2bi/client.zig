const aws = @import("aws");
const std = @import("std");

const create_capability = @import("create_capability.zig");
const create_partnership = @import("create_partnership.zig");
const create_profile = @import("create_profile.zig");
const create_starter_mapping_template = @import("create_starter_mapping_template.zig");
const create_transformer = @import("create_transformer.zig");
const delete_capability = @import("delete_capability.zig");
const delete_partnership = @import("delete_partnership.zig");
const delete_profile = @import("delete_profile.zig");
const delete_transformer = @import("delete_transformer.zig");
const generate_mapping = @import("generate_mapping.zig");
const get_capability = @import("get_capability.zig");
const get_partnership = @import("get_partnership.zig");
const get_profile = @import("get_profile.zig");
const get_transformer = @import("get_transformer.zig");
const get_transformer_job = @import("get_transformer_job.zig");
const list_capabilities = @import("list_capabilities.zig");
const list_partnerships = @import("list_partnerships.zig");
const list_profiles = @import("list_profiles.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_transformers = @import("list_transformers.zig");
const start_transformer_job = @import("start_transformer_job.zig");
const tag_resource = @import("tag_resource.zig");
const test_conversion = @import("test_conversion.zig");
const test_mapping = @import("test_mapping.zig");
const test_parsing = @import("test_parsing.zig");
const untag_resource = @import("untag_resource.zig");
const update_capability = @import("update_capability.zig");
const update_partnership = @import("update_partnership.zig");
const update_profile = @import("update_profile.zig");
const update_transformer = @import("update_transformer.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "b2bi";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Instantiates a capability based on the specified parameters. A trading
    /// capability contains the information required to transform incoming EDI
    /// documents into JSON or XML outputs.
    pub fn createCapability(self: *Self, allocator: std.mem.Allocator, input: create_capability.CreateCapabilityInput, options: create_capability.Options) !create_capability.CreateCapabilityOutput {
        return create_capability.execute(self, allocator, input, options);
    }

    /// Creates a partnership between a customer and a trading partner, based on the
    /// supplied parameters. A partnership represents the connection between you and
    /// your trading partner. It ties together a profile and one or more trading
    /// capabilities.
    pub fn createPartnership(self: *Self, allocator: std.mem.Allocator, input: create_partnership.CreatePartnershipInput, options: create_partnership.Options) !create_partnership.CreatePartnershipOutput {
        return create_partnership.execute(self, allocator, input, options);
    }

    /// Creates a customer profile. You can have up to five customer profiles, each
    /// representing a distinct private network. A profile is the mechanism used to
    /// create the concept of a private network.
    pub fn createProfile(self: *Self, allocator: std.mem.Allocator, input: create_profile.CreateProfileInput, options: create_profile.Options) !create_profile.CreateProfileOutput {
        return create_profile.execute(self, allocator, input, options);
    }

    /// Amazon Web Services B2B Data Interchange uses a mapping template in JSONata
    /// or XSLT format to transform a customer input file into a JSON or XML file
    /// that can be converted to EDI.
    ///
    /// If you provide a sample EDI file with the same structure as the EDI files
    /// that you wish to generate, then the service can generate a mapping template.
    /// The starter template contains placeholder values which you can replace with
    /// JSONata or XSLT expressions to take data from your input file and insert it
    /// into the JSON or XML file that is used to generate the EDI.
    ///
    /// If you do not provide a sample EDI file, then the service can generate a
    /// mapping template based on the EDI settings in the `templateDetails`
    /// parameter.
    ///
    /// Currently, we only support generating a template that can generate the input
    /// to produce an Outbound X12 EDI file.
    pub fn createStarterMappingTemplate(self: *Self, allocator: std.mem.Allocator, input: create_starter_mapping_template.CreateStarterMappingTemplateInput, options: create_starter_mapping_template.Options) !create_starter_mapping_template.CreateStarterMappingTemplateOutput {
        return create_starter_mapping_template.execute(self, allocator, input, options);
    }

    /// Creates a transformer. Amazon Web Services B2B Data Interchange currently
    /// supports two scenarios:
    ///
    /// * *Inbound EDI*: the Amazon Web Services customer receives an EDI file from
    ///   their trading partner. Amazon Web Services B2B Data Interchange converts
    ///   this EDI file into a JSON or XML file with a service-defined structure. A
    ///   mapping template provided by the customer, in JSONata or XSLT format, is
    ///   optionally applied to this file to produce a JSON or XML file with the
    ///   structure the customer requires.
    /// * *Outbound EDI*: the Amazon Web Services customer has a JSON or XML file
    ///   containing data that they wish to use in an EDI file. A mapping template,
    ///   provided by the customer (in either JSONata or XSLT format) is applied to
    ///   this file to generate a JSON or XML file in the service-defined structure.
    ///   This file is then converted to an EDI file.
    ///
    /// The following fields are provided for backwards compatibility only:
    /// `fileFormat`, `mappingTemplate`, `ediType`, and `sampleDocument`.
    ///
    /// * Use the `mapping` data type in place of `mappingTemplate` and `fileFormat`
    /// * Use the `sampleDocuments` data type in place of `sampleDocument`
    /// * Use either the `inputConversion` or `outputConversion` in place of
    ///   `ediType`
    pub fn createTransformer(self: *Self, allocator: std.mem.Allocator, input: create_transformer.CreateTransformerInput, options: create_transformer.Options) !create_transformer.CreateTransformerOutput {
        return create_transformer.execute(self, allocator, input, options);
    }

    /// Deletes the specified capability. A trading capability contains the
    /// information required to transform incoming EDI documents into JSON or XML
    /// outputs.
    pub fn deleteCapability(self: *Self, allocator: std.mem.Allocator, input: delete_capability.DeleteCapabilityInput, options: delete_capability.Options) !delete_capability.DeleteCapabilityOutput {
        return delete_capability.execute(self, allocator, input, options);
    }

    /// Deletes the specified partnership. A partnership represents the connection
    /// between you and your trading partner. It ties together a profile and one or
    /// more trading capabilities.
    pub fn deletePartnership(self: *Self, allocator: std.mem.Allocator, input: delete_partnership.DeletePartnershipInput, options: delete_partnership.Options) !delete_partnership.DeletePartnershipOutput {
        return delete_partnership.execute(self, allocator, input, options);
    }

    /// Deletes the specified profile. A profile is the mechanism used to create the
    /// concept of a private network.
    pub fn deleteProfile(self: *Self, allocator: std.mem.Allocator, input: delete_profile.DeleteProfileInput, options: delete_profile.Options) !delete_profile.DeleteProfileOutput {
        return delete_profile.execute(self, allocator, input, options);
    }

    /// Deletes the specified transformer. A transformer can take an EDI file as
    /// input and transform it into a JSON-or XML-formatted document. Alternatively,
    /// a transformer can take a JSON-or XML-formatted document as input and
    /// transform it into an EDI file.
    pub fn deleteTransformer(self: *Self, allocator: std.mem.Allocator, input: delete_transformer.DeleteTransformerInput, options: delete_transformer.Options) !delete_transformer.DeleteTransformerOutput {
        return delete_transformer.execute(self, allocator, input, options);
    }

    /// Takes sample input and output documents and uses Amazon Bedrock to generate
    /// a mapping automatically. Depending on the accuracy and other factors, you
    /// can then edit the mapping for your needs.
    ///
    /// Before you can use the AI-assisted feature for Amazon Web Services B2B Data
    /// Interchange you must enable models in Amazon Bedrock. For details, see
    /// [AI-assisted template mapping
    /// prerequisites](https://docs.aws.amazon.com/b2bi/latest/userguide/ai-assisted-mapping.html#ai-assist-prereq) in the *Amazon Web Services B2B Data Interchange User guide*.
    ///
    /// To generate a mapping, perform the following steps:
    ///
    /// * Start with an X12 EDI document to use as the input.
    /// * Call `TestMapping` using your EDI document.
    /// * Use the output from the `TestMapping` operation as either input or output
    ///   for your GenerateMapping call, along with your sample file.
    pub fn generateMapping(self: *Self, allocator: std.mem.Allocator, input: generate_mapping.GenerateMappingInput, options: generate_mapping.Options) !generate_mapping.GenerateMappingOutput {
        return generate_mapping.execute(self, allocator, input, options);
    }

    /// Retrieves the details for the specified capability. A trading capability
    /// contains the information required to transform incoming EDI documents into
    /// JSON or XML outputs.
    pub fn getCapability(self: *Self, allocator: std.mem.Allocator, input: get_capability.GetCapabilityInput, options: get_capability.Options) !get_capability.GetCapabilityOutput {
        return get_capability.execute(self, allocator, input, options);
    }

    /// Retrieves the details for a partnership, based on the partner and profile
    /// IDs specified. A partnership represents the connection between you and your
    /// trading partner. It ties together a profile and one or more trading
    /// capabilities.
    pub fn getPartnership(self: *Self, allocator: std.mem.Allocator, input: get_partnership.GetPartnershipInput, options: get_partnership.Options) !get_partnership.GetPartnershipOutput {
        return get_partnership.execute(self, allocator, input, options);
    }

    /// Retrieves the details for the profile specified by the profile ID. A profile
    /// is the mechanism used to create the concept of a private network.
    pub fn getProfile(self: *Self, allocator: std.mem.Allocator, input: get_profile.GetProfileInput, options: get_profile.Options) !get_profile.GetProfileOutput {
        return get_profile.execute(self, allocator, input, options);
    }

    /// Retrieves the details for the transformer specified by the transformer ID. A
    /// transformer can take an EDI file as input and transform it into a JSON-or
    /// XML-formatted document. Alternatively, a transformer can take a JSON-or
    /// XML-formatted document as input and transform it into an EDI file.
    pub fn getTransformer(self: *Self, allocator: std.mem.Allocator, input: get_transformer.GetTransformerInput, options: get_transformer.Options) !get_transformer.GetTransformerOutput {
        return get_transformer.execute(self, allocator, input, options);
    }

    /// Returns the details of the transformer run, based on the Transformer job ID.
    ///
    /// If 30 days have elapsed since your transformer job was started, the system
    /// deletes it. So, if you run `GetTransformerJob` and supply a `transformerId`
    /// and `transformerJobId` for a job that was started more than 30 days
    /// previously, you receive a 404 response.
    pub fn getTransformerJob(self: *Self, allocator: std.mem.Allocator, input: get_transformer_job.GetTransformerJobInput, options: get_transformer_job.Options) !get_transformer_job.GetTransformerJobOutput {
        return get_transformer_job.execute(self, allocator, input, options);
    }

    /// Lists the capabilities associated with your Amazon Web Services account for
    /// your current or specified region. A trading capability contains the
    /// information required to transform incoming EDI documents into JSON or XML
    /// outputs.
    pub fn listCapabilities(self: *Self, allocator: std.mem.Allocator, input: list_capabilities.ListCapabilitiesInput, options: list_capabilities.Options) !list_capabilities.ListCapabilitiesOutput {
        return list_capabilities.execute(self, allocator, input, options);
    }

    /// Lists the partnerships associated with your Amazon Web Services account for
    /// your current or specified region. A partnership represents the connection
    /// between you and your trading partner. It ties together a profile and one or
    /// more trading capabilities.
    pub fn listPartnerships(self: *Self, allocator: std.mem.Allocator, input: list_partnerships.ListPartnershipsInput, options: list_partnerships.Options) !list_partnerships.ListPartnershipsOutput {
        return list_partnerships.execute(self, allocator, input, options);
    }

    /// Lists the profiles associated with your Amazon Web Services account for your
    /// current or specified region. A profile is the mechanism used to create the
    /// concept of a private network.
    pub fn listProfiles(self: *Self, allocator: std.mem.Allocator, input: list_profiles.ListProfilesInput, options: list_profiles.Options) !list_profiles.ListProfilesOutput {
        return list_profiles.execute(self, allocator, input, options);
    }

    /// Lists all of the tags associated with the Amazon Resource Name (ARN) that
    /// you specify. The resource can be a capability, partnership, profile, or
    /// transformer.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the available transformers. A transformer can take an EDI file as
    /// input and transform it into a JSON-or XML-formatted document. Alternatively,
    /// a transformer can take a JSON-or XML-formatted document as input and
    /// transform it into an EDI file.
    pub fn listTransformers(self: *Self, allocator: std.mem.Allocator, input: list_transformers.ListTransformersInput, options: list_transformers.Options) !list_transformers.ListTransformersOutput {
        return list_transformers.execute(self, allocator, input, options);
    }

    /// Runs a job, using a transformer, to parse input EDI (electronic data
    /// interchange) file into the output structures used by Amazon Web Services B2B
    /// Data Interchange.
    ///
    /// If you only want to transform EDI (electronic data interchange) documents,
    /// you don't need to create profiles, partnerships or capabilities. Just create
    /// and configure a transformer, and then run the `StartTransformerJob` API to
    /// process your files.
    ///
    /// The system stores transformer jobs for 30 days. During that period, you can
    /// run
    /// [GetTransformerJob](https://docs.aws.amazon.com/b2bi/latest/APIReference/API_GetTransformerJob.html) and supply its `transformerId` and `transformerJobId` to return details of the job.
    pub fn startTransformerJob(self: *Self, allocator: std.mem.Allocator, input: start_transformer_job.StartTransformerJobInput, options: start_transformer_job.Options) !start_transformer_job.StartTransformerJobOutput {
        return start_transformer_job.execute(self, allocator, input, options);
    }

    /// Attaches a key-value pair to a resource, as identified by its Amazon
    /// Resource Name (ARN). Resources are capability, partnership, profile,
    /// transformers and other entities.
    ///
    /// There is no response returned from this call.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// This operation mimics the latter half of a typical Outbound EDI request. It
    /// takes an input JSON/XML in the B2Bi shape as input, converts it to an X12
    /// EDI string, and return that string.
    pub fn testConversion(self: *Self, allocator: std.mem.Allocator, input: test_conversion.TestConversionInput, options: test_conversion.Options) !test_conversion.TestConversionOutput {
        return test_conversion.execute(self, allocator, input, options);
    }

    /// Maps the input file according to the provided template file. The API call
    /// downloads the file contents from the Amazon S3 location, and passes the
    /// contents in as a string, to the `inputFileContent` parameter.
    pub fn testMapping(self: *Self, allocator: std.mem.Allocator, input: test_mapping.TestMappingInput, options: test_mapping.Options) !test_mapping.TestMappingOutput {
        return test_mapping.execute(self, allocator, input, options);
    }

    /// Parses the input EDI (electronic data interchange) file. The input file has
    /// a file size limit of 250 KB.
    pub fn testParsing(self: *Self, allocator: std.mem.Allocator, input: test_parsing.TestParsingInput, options: test_parsing.Options) !test_parsing.TestParsingOutput {
        return test_parsing.execute(self, allocator, input, options);
    }

    /// Detaches a key-value pair from the specified resource, as identified by its
    /// Amazon Resource Name (ARN). Resources are capability, partnership, profile,
    /// transformers and other entities.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates some of the parameters for a capability, based on the specified
    /// parameters. A trading capability contains the information required to
    /// transform incoming EDI documents into JSON or XML outputs.
    pub fn updateCapability(self: *Self, allocator: std.mem.Allocator, input: update_capability.UpdateCapabilityInput, options: update_capability.Options) !update_capability.UpdateCapabilityOutput {
        return update_capability.execute(self, allocator, input, options);
    }

    /// Updates some of the parameters for a partnership between a customer and
    /// trading partner. A partnership represents the connection between you and
    /// your trading partner. It ties together a profile and one or more trading
    /// capabilities.
    pub fn updatePartnership(self: *Self, allocator: std.mem.Allocator, input: update_partnership.UpdatePartnershipInput, options: update_partnership.Options) !update_partnership.UpdatePartnershipOutput {
        return update_partnership.execute(self, allocator, input, options);
    }

    /// Updates the specified parameters for a profile. A profile is the mechanism
    /// used to create the concept of a private network.
    pub fn updateProfile(self: *Self, allocator: std.mem.Allocator, input: update_profile.UpdateProfileInput, options: update_profile.Options) !update_profile.UpdateProfileOutput {
        return update_profile.execute(self, allocator, input, options);
    }

    /// Updates the specified parameters for a transformer. A transformer can take
    /// an EDI file as input and transform it into a JSON-or XML-formatted document.
    /// Alternatively, a transformer can take a JSON-or XML-formatted document as
    /// input and transform it into an EDI file.
    pub fn updateTransformer(self: *Self, allocator: std.mem.Allocator, input: update_transformer.UpdateTransformerInput, options: update_transformer.Options) !update_transformer.UpdateTransformerOutput {
        return update_transformer.execute(self, allocator, input, options);
    }

    pub fn listCapabilitiesPaginator(self: *Self, params: list_capabilities.ListCapabilitiesInput) paginator.ListCapabilitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPartnershipsPaginator(self: *Self, params: list_partnerships.ListPartnershipsInput) paginator.ListPartnershipsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProfilesPaginator(self: *Self, params: list_profiles.ListProfilesInput) paginator.ListProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTransformersPaginator(self: *Self, params: list_transformers.ListTransformersInput) paginator.ListTransformersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilTransformerJobSucceeded(self: *Self, params: get_transformer_job.GetTransformerJobInput) aws.waiter.WaiterError!void {
        var w = waiters.TransformerJobSucceededWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
