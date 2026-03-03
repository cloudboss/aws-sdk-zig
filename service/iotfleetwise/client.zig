const aws = @import("aws");
const std = @import("std");

const associate_vehicle_fleet = @import("associate_vehicle_fleet.zig");
const batch_create_vehicle = @import("batch_create_vehicle.zig");
const batch_update_vehicle = @import("batch_update_vehicle.zig");
const create_campaign = @import("create_campaign.zig");
const create_decoder_manifest = @import("create_decoder_manifest.zig");
const create_fleet = @import("create_fleet.zig");
const create_model_manifest = @import("create_model_manifest.zig");
const create_signal_catalog = @import("create_signal_catalog.zig");
const create_state_template = @import("create_state_template.zig");
const create_vehicle = @import("create_vehicle.zig");
const delete_campaign = @import("delete_campaign.zig");
const delete_decoder_manifest = @import("delete_decoder_manifest.zig");
const delete_fleet = @import("delete_fleet.zig");
const delete_model_manifest = @import("delete_model_manifest.zig");
const delete_signal_catalog = @import("delete_signal_catalog.zig");
const delete_state_template = @import("delete_state_template.zig");
const delete_vehicle = @import("delete_vehicle.zig");
const disassociate_vehicle_fleet = @import("disassociate_vehicle_fleet.zig");
const get_campaign = @import("get_campaign.zig");
const get_decoder_manifest = @import("get_decoder_manifest.zig");
const get_encryption_configuration = @import("get_encryption_configuration.zig");
const get_fleet = @import("get_fleet.zig");
const get_logging_options = @import("get_logging_options.zig");
const get_model_manifest = @import("get_model_manifest.zig");
const get_register_account_status = @import("get_register_account_status.zig");
const get_signal_catalog = @import("get_signal_catalog.zig");
const get_state_template = @import("get_state_template.zig");
const get_vehicle = @import("get_vehicle.zig");
const get_vehicle_status = @import("get_vehicle_status.zig");
const import_decoder_manifest = @import("import_decoder_manifest.zig");
const import_signal_catalog = @import("import_signal_catalog.zig");
const list_campaigns = @import("list_campaigns.zig");
const list_decoder_manifest_network_interfaces = @import("list_decoder_manifest_network_interfaces.zig");
const list_decoder_manifest_signals = @import("list_decoder_manifest_signals.zig");
const list_decoder_manifests = @import("list_decoder_manifests.zig");
const list_fleets = @import("list_fleets.zig");
const list_fleets_for_vehicle = @import("list_fleets_for_vehicle.zig");
const list_model_manifest_nodes = @import("list_model_manifest_nodes.zig");
const list_model_manifests = @import("list_model_manifests.zig");
const list_signal_catalog_nodes = @import("list_signal_catalog_nodes.zig");
const list_signal_catalogs = @import("list_signal_catalogs.zig");
const list_state_templates = @import("list_state_templates.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_vehicles = @import("list_vehicles.zig");
const list_vehicles_in_fleet = @import("list_vehicles_in_fleet.zig");
const put_encryption_configuration = @import("put_encryption_configuration.zig");
const put_logging_options = @import("put_logging_options.zig");
const register_account = @import("register_account.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_campaign = @import("update_campaign.zig");
const update_decoder_manifest = @import("update_decoder_manifest.zig");
const update_fleet = @import("update_fleet.zig");
const update_model_manifest = @import("update_model_manifest.zig");
const update_signal_catalog = @import("update_signal_catalog.zig");
const update_state_template = @import("update_state_template.zig");
const update_vehicle = @import("update_vehicle.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoTFleetWise";

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

    /// Adds, or associates, a vehicle with a fleet.
    pub fn associateVehicleFleet(self: *Self, allocator: std.mem.Allocator, input: associate_vehicle_fleet.AssociateVehicleFleetInput, options: associate_vehicle_fleet.Options) !associate_vehicle_fleet.AssociateVehicleFleetOutput {
        return associate_vehicle_fleet.execute(self, allocator, input, options);
    }

    /// Creates a group, or batch, of vehicles.
    ///
    /// You must specify a decoder manifest and a vehicle model (model manifest) for
    /// each
    /// vehicle.
    ///
    /// For more information, see [Create multiple
    /// vehicles (AWS
    /// CLI)](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/create-vehicles-cli.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn batchCreateVehicle(self: *Self, allocator: std.mem.Allocator, input: batch_create_vehicle.BatchCreateVehicleInput, options: batch_create_vehicle.Options) !batch_create_vehicle.BatchCreateVehicleOutput {
        return batch_create_vehicle.execute(self, allocator, input, options);
    }

    /// Updates a group, or batch, of vehicles.
    ///
    /// You must specify a decoder manifest and a vehicle model (model manifest) for
    /// each
    /// vehicle.
    ///
    /// For more information, see [Update multiple
    /// vehicles (AWS
    /// CLI)](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/update-vehicles-cli.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn batchUpdateVehicle(self: *Self, allocator: std.mem.Allocator, input: batch_update_vehicle.BatchUpdateVehicleInput, options: batch_update_vehicle.Options) !batch_update_vehicle.BatchUpdateVehicleOutput {
        return batch_update_vehicle.execute(self, allocator, input, options);
    }

    /// Creates an orchestration of data collection rules. The Amazon Web Services
    /// IoT FleetWise Edge Agent software
    /// running in vehicles uses campaigns to decide how to collect and transfer
    /// data to the
    /// cloud. You create campaigns in the cloud. After you or your team approve
    /// campaigns,
    /// Amazon Web Services IoT FleetWise automatically deploys them to vehicles.
    ///
    /// For more information, see [Collect and transfer data
    /// with
    /// campaigns](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/campaigns.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    ///
    /// Access to certain Amazon Web Services IoT FleetWise features is currently
    /// gated. For more information, see [Amazon Web Services Region and feature
    /// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn createCampaign(self: *Self, allocator: std.mem.Allocator, input: create_campaign.CreateCampaignInput, options: create_campaign.Options) !create_campaign.CreateCampaignOutput {
        return create_campaign.execute(self, allocator, input, options);
    }

    /// Creates the decoder manifest associated with a model manifest. To create a
    /// decoder
    /// manifest, the following must be true:
    ///
    /// * Every signal decoder has a unique name.
    ///
    /// * Each signal decoder is associated with a network interface.
    ///
    /// * Each network interface has a unique ID.
    ///
    /// * The signal decoders are specified in the model manifest.
    pub fn createDecoderManifest(self: *Self, allocator: std.mem.Allocator, input: create_decoder_manifest.CreateDecoderManifestInput, options: create_decoder_manifest.Options) !create_decoder_manifest.CreateDecoderManifestOutput {
        return create_decoder_manifest.execute(self, allocator, input, options);
    }

    /// Creates a fleet that represents a group of vehicles.
    ///
    /// You must create both a signal catalog and vehicles before you can create a
    /// fleet.
    ///
    /// For more information, see
    /// [Fleets](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleets.html) in the
    /// *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn createFleet(self: *Self, allocator: std.mem.Allocator, input: create_fleet.CreateFleetInput, options: create_fleet.Options) !create_fleet.CreateFleetOutput {
        return create_fleet.execute(self, allocator, input, options);
    }

    /// Creates a vehicle model (model manifest) that specifies signals (attributes,
    /// branches, sensors, and actuators).
    ///
    /// For more information, see [Vehicle
    /// models](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/vehicle-models.html)
    /// in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn createModelManifest(self: *Self, allocator: std.mem.Allocator, input: create_model_manifest.CreateModelManifestInput, options: create_model_manifest.Options) !create_model_manifest.CreateModelManifestOutput {
        return create_model_manifest.execute(self, allocator, input, options);
    }

    /// Creates a collection of standardized signals that can be reused to create
    /// vehicle
    /// models.
    pub fn createSignalCatalog(self: *Self, allocator: std.mem.Allocator, input: create_signal_catalog.CreateSignalCatalogInput, options: create_signal_catalog.Options) !create_signal_catalog.CreateSignalCatalogOutput {
        return create_signal_catalog.execute(self, allocator, input, options);
    }

    /// Creates a state template. State templates contain state properties, which
    /// are signals that belong to a signal catalog that is synchronized between the
    /// Amazon Web Services IoT FleetWise Edge and the Amazon Web Services Cloud.
    ///
    /// Access to certain Amazon Web Services IoT FleetWise features is currently
    /// gated. For more information, see [Amazon Web Services Region and feature
    /// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn createStateTemplate(self: *Self, allocator: std.mem.Allocator, input: create_state_template.CreateStateTemplateInput, options: create_state_template.Options) !create_state_template.CreateStateTemplateOutput {
        return create_state_template.execute(self, allocator, input, options);
    }

    /// Creates a vehicle, which is an instance of a vehicle model (model manifest).
    /// Vehicles
    /// created from the same vehicle model consist of the same signals inherited
    /// from the
    /// vehicle model.
    ///
    /// If you have an existing Amazon Web Services IoT thing, you can use Amazon
    /// Web Services IoT FleetWise to create a
    /// vehicle and collect data from your thing.
    ///
    /// For more information, see [Create a vehicle
    /// (AWS
    /// CLI)](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/create-vehicle-cli.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn createVehicle(self: *Self, allocator: std.mem.Allocator, input: create_vehicle.CreateVehicleInput, options: create_vehicle.Options) !create_vehicle.CreateVehicleOutput {
        return create_vehicle.execute(self, allocator, input, options);
    }

    /// Deletes a data collection campaign. Deleting a campaign suspends all data
    /// collection
    /// and removes it from any vehicles.
    pub fn deleteCampaign(self: *Self, allocator: std.mem.Allocator, input: delete_campaign.DeleteCampaignInput, options: delete_campaign.Options) !delete_campaign.DeleteCampaignOutput {
        return delete_campaign.execute(self, allocator, input, options);
    }

    /// Deletes a decoder manifest. You can't delete a decoder manifest if it has
    /// vehicles
    /// associated with it.
    pub fn deleteDecoderManifest(self: *Self, allocator: std.mem.Allocator, input: delete_decoder_manifest.DeleteDecoderManifestInput, options: delete_decoder_manifest.Options) !delete_decoder_manifest.DeleteDecoderManifestOutput {
        return delete_decoder_manifest.execute(self, allocator, input, options);
    }

    /// Deletes a fleet. Before you delete a fleet, all vehicles must be
    /// dissociated from the fleet. For more information, see [Delete a fleet (AWS
    /// CLI)](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/delete-fleet-cli.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn deleteFleet(self: *Self, allocator: std.mem.Allocator, input: delete_fleet.DeleteFleetInput, options: delete_fleet.Options) !delete_fleet.DeleteFleetOutput {
        return delete_fleet.execute(self, allocator, input, options);
    }

    /// Deletes a vehicle model (model manifest).
    pub fn deleteModelManifest(self: *Self, allocator: std.mem.Allocator, input: delete_model_manifest.DeleteModelManifestInput, options: delete_model_manifest.Options) !delete_model_manifest.DeleteModelManifestOutput {
        return delete_model_manifest.execute(self, allocator, input, options);
    }

    /// Deletes a signal catalog.
    pub fn deleteSignalCatalog(self: *Self, allocator: std.mem.Allocator, input: delete_signal_catalog.DeleteSignalCatalogInput, options: delete_signal_catalog.Options) !delete_signal_catalog.DeleteSignalCatalogOutput {
        return delete_signal_catalog.execute(self, allocator, input, options);
    }

    /// Deletes a state template.
    pub fn deleteStateTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_state_template.DeleteStateTemplateInput, options: delete_state_template.Options) !delete_state_template.DeleteStateTemplateOutput {
        return delete_state_template.execute(self, allocator, input, options);
    }

    /// Deletes a vehicle and removes it from any campaigns.
    pub fn deleteVehicle(self: *Self, allocator: std.mem.Allocator, input: delete_vehicle.DeleteVehicleInput, options: delete_vehicle.Options) !delete_vehicle.DeleteVehicleOutput {
        return delete_vehicle.execute(self, allocator, input, options);
    }

    /// Removes, or disassociates, a vehicle from a fleet. Disassociating a vehicle
    /// from a
    /// fleet doesn't delete the vehicle.
    pub fn disassociateVehicleFleet(self: *Self, allocator: std.mem.Allocator, input: disassociate_vehicle_fleet.DisassociateVehicleFleetInput, options: disassociate_vehicle_fleet.Options) !disassociate_vehicle_fleet.DisassociateVehicleFleetOutput {
        return disassociate_vehicle_fleet.execute(self, allocator, input, options);
    }

    /// Retrieves information about a campaign.
    ///
    /// Access to certain Amazon Web Services IoT FleetWise features is currently
    /// gated. For more information, see [Amazon Web Services Region and feature
    /// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn getCampaign(self: *Self, allocator: std.mem.Allocator, input: get_campaign.GetCampaignInput, options: get_campaign.Options) !get_campaign.GetCampaignOutput {
        return get_campaign.execute(self, allocator, input, options);
    }

    /// Retrieves information about a created decoder manifest.
    pub fn getDecoderManifest(self: *Self, allocator: std.mem.Allocator, input: get_decoder_manifest.GetDecoderManifestInput, options: get_decoder_manifest.Options) !get_decoder_manifest.GetDecoderManifestOutput {
        return get_decoder_manifest.execute(self, allocator, input, options);
    }

    /// Retrieves the encryption configuration for resources and data in Amazon Web
    /// Services IoT FleetWise.
    pub fn getEncryptionConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_encryption_configuration.GetEncryptionConfigurationInput, options: get_encryption_configuration.Options) !get_encryption_configuration.GetEncryptionConfigurationOutput {
        return get_encryption_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves information about a fleet.
    pub fn getFleet(self: *Self, allocator: std.mem.Allocator, input: get_fleet.GetFleetInput, options: get_fleet.Options) !get_fleet.GetFleetOutput {
        return get_fleet.execute(self, allocator, input, options);
    }

    /// Retrieves the logging options.
    pub fn getLoggingOptions(self: *Self, allocator: std.mem.Allocator, input: get_logging_options.GetLoggingOptionsInput, options: get_logging_options.Options) !get_logging_options.GetLoggingOptionsOutput {
        return get_logging_options.execute(self, allocator, input, options);
    }

    /// Retrieves information about a vehicle model (model manifest).
    pub fn getModelManifest(self: *Self, allocator: std.mem.Allocator, input: get_model_manifest.GetModelManifestInput, options: get_model_manifest.Options) !get_model_manifest.GetModelManifestOutput {
        return get_model_manifest.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status of registering your Amazon Web
    /// Services account, IAM, and
    /// Amazon Timestream resources so that Amazon Web Services IoT FleetWise can
    /// transfer your vehicle data to the Amazon Web Services
    /// Cloud.
    ///
    /// For more information, including step-by-step procedures, see [Setting up
    /// Amazon Web Services IoT
    /// FleetWise](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/setting-up.html).
    ///
    /// This API operation doesn't require input parameters.
    pub fn getRegisterAccountStatus(self: *Self, allocator: std.mem.Allocator, input: get_register_account_status.GetRegisterAccountStatusInput, options: get_register_account_status.Options) !get_register_account_status.GetRegisterAccountStatusOutput {
        return get_register_account_status.execute(self, allocator, input, options);
    }

    /// Retrieves information about a signal catalog.
    pub fn getSignalCatalog(self: *Self, allocator: std.mem.Allocator, input: get_signal_catalog.GetSignalCatalogInput, options: get_signal_catalog.Options) !get_signal_catalog.GetSignalCatalogOutput {
        return get_signal_catalog.execute(self, allocator, input, options);
    }

    /// Retrieves information about a state template.
    ///
    /// Access to certain Amazon Web Services IoT FleetWise features is currently
    /// gated. For more information, see [Amazon Web Services Region and feature
    /// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn getStateTemplate(self: *Self, allocator: std.mem.Allocator, input: get_state_template.GetStateTemplateInput, options: get_state_template.Options) !get_state_template.GetStateTemplateOutput {
        return get_state_template.execute(self, allocator, input, options);
    }

    /// Retrieves information about a vehicle.
    pub fn getVehicle(self: *Self, allocator: std.mem.Allocator, input: get_vehicle.GetVehicleInput, options: get_vehicle.Options) !get_vehicle.GetVehicleOutput {
        return get_vehicle.execute(self, allocator, input, options);
    }

    /// Retrieves information about the status of campaigns, decoder manifests, or
    /// state templates
    /// associated with a vehicle.
    pub fn getVehicleStatus(self: *Self, allocator: std.mem.Allocator, input: get_vehicle_status.GetVehicleStatusInput, options: get_vehicle_status.Options) !get_vehicle_status.GetVehicleStatusOutput {
        return get_vehicle_status.execute(self, allocator, input, options);
    }

    /// Creates a decoder manifest using your existing CAN DBC file from your local
    /// device.
    ///
    /// The CAN signal name must be unique and not repeated across CAN message
    /// definitions in a .dbc file.
    pub fn importDecoderManifest(self: *Self, allocator: std.mem.Allocator, input: import_decoder_manifest.ImportDecoderManifestInput, options: import_decoder_manifest.Options) !import_decoder_manifest.ImportDecoderManifestOutput {
        return import_decoder_manifest.execute(self, allocator, input, options);
    }

    /// Creates a signal catalog using your existing VSS formatted content from your
    /// local
    /// device.
    pub fn importSignalCatalog(self: *Self, allocator: std.mem.Allocator, input: import_signal_catalog.ImportSignalCatalogInput, options: import_signal_catalog.Options) !import_signal_catalog.ImportSignalCatalogOutput {
        return import_signal_catalog.execute(self, allocator, input, options);
    }

    /// Lists information about created campaigns.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listCampaigns(self: *Self, allocator: std.mem.Allocator, input: list_campaigns.ListCampaignsInput, options: list_campaigns.Options) !list_campaigns.ListCampaignsOutput {
        return list_campaigns.execute(self, allocator, input, options);
    }

    /// Lists the network interfaces specified in a decoder manifest.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listDecoderManifestNetworkInterfaces(self: *Self, allocator: std.mem.Allocator, input: list_decoder_manifest_network_interfaces.ListDecoderManifestNetworkInterfacesInput, options: list_decoder_manifest_network_interfaces.Options) !list_decoder_manifest_network_interfaces.ListDecoderManifestNetworkInterfacesOutput {
        return list_decoder_manifest_network_interfaces.execute(self, allocator, input, options);
    }

    /// A list of information about signal decoders specified in a decoder manifest.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listDecoderManifestSignals(self: *Self, allocator: std.mem.Allocator, input: list_decoder_manifest_signals.ListDecoderManifestSignalsInput, options: list_decoder_manifest_signals.Options) !list_decoder_manifest_signals.ListDecoderManifestSignalsOutput {
        return list_decoder_manifest_signals.execute(self, allocator, input, options);
    }

    /// Lists decoder manifests.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listDecoderManifests(self: *Self, allocator: std.mem.Allocator, input: list_decoder_manifests.ListDecoderManifestsInput, options: list_decoder_manifests.Options) !list_decoder_manifests.ListDecoderManifestsOutput {
        return list_decoder_manifests.execute(self, allocator, input, options);
    }

    /// Retrieves information for each created fleet in an Amazon Web Services
    /// account.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listFleets(self: *Self, allocator: std.mem.Allocator, input: list_fleets.ListFleetsInput, options: list_fleets.Options) !list_fleets.ListFleetsOutput {
        return list_fleets.execute(self, allocator, input, options);
    }

    /// Retrieves a list of IDs for all fleets that the vehicle is associated with.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listFleetsForVehicle(self: *Self, allocator: std.mem.Allocator, input: list_fleets_for_vehicle.ListFleetsForVehicleInput, options: list_fleets_for_vehicle.Options) !list_fleets_for_vehicle.ListFleetsForVehicleOutput {
        return list_fleets_for_vehicle.execute(self, allocator, input, options);
    }

    /// Lists information about nodes specified in a vehicle model (model manifest).
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listModelManifestNodes(self: *Self, allocator: std.mem.Allocator, input: list_model_manifest_nodes.ListModelManifestNodesInput, options: list_model_manifest_nodes.Options) !list_model_manifest_nodes.ListModelManifestNodesOutput {
        return list_model_manifest_nodes.execute(self, allocator, input, options);
    }

    /// Retrieves a list of vehicle models (model manifests).
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listModelManifests(self: *Self, allocator: std.mem.Allocator, input: list_model_manifests.ListModelManifestsInput, options: list_model_manifests.Options) !list_model_manifests.ListModelManifestsOutput {
        return list_model_manifests.execute(self, allocator, input, options);
    }

    /// Lists of information about the signals (nodes) specified in a signal
    /// catalog.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listSignalCatalogNodes(self: *Self, allocator: std.mem.Allocator, input: list_signal_catalog_nodes.ListSignalCatalogNodesInput, options: list_signal_catalog_nodes.Options) !list_signal_catalog_nodes.ListSignalCatalogNodesOutput {
        return list_signal_catalog_nodes.execute(self, allocator, input, options);
    }

    /// Lists all the created signal catalogs in an Amazon Web Services account.
    ///
    /// You can use to list information about
    /// each signal (node) specified in a signal catalog.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listSignalCatalogs(self: *Self, allocator: std.mem.Allocator, input: list_signal_catalogs.ListSignalCatalogsInput, options: list_signal_catalogs.Options) !list_signal_catalogs.ListSignalCatalogsOutput {
        return list_signal_catalogs.execute(self, allocator, input, options);
    }

    /// Lists information about created state templates.
    ///
    /// Access to certain Amazon Web Services IoT FleetWise features is currently
    /// gated. For more information, see [Amazon Web Services Region and feature
    /// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn listStateTemplates(self: *Self, allocator: std.mem.Allocator, input: list_state_templates.ListStateTemplatesInput, options: list_state_templates.Options) !list_state_templates.ListStateTemplatesOutput {
        return list_state_templates.execute(self, allocator, input, options);
    }

    /// Lists the tags (metadata) you have assigned to the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves a list of summaries of created vehicles.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listVehicles(self: *Self, allocator: std.mem.Allocator, input: list_vehicles.ListVehiclesInput, options: list_vehicles.Options) !list_vehicles.ListVehiclesOutput {
        return list_vehicles.execute(self, allocator, input, options);
    }

    /// Retrieves a list of summaries of all vehicles associated with a fleet.
    ///
    /// This API operation uses pagination. Specify the `nextToken` parameter in the
    /// request to return more results.
    pub fn listVehiclesInFleet(self: *Self, allocator: std.mem.Allocator, input: list_vehicles_in_fleet.ListVehiclesInFleetInput, options: list_vehicles_in_fleet.Options) !list_vehicles_in_fleet.ListVehiclesInFleetOutput {
        return list_vehicles_in_fleet.execute(self, allocator, input, options);
    }

    /// Creates or updates the encryption configuration. Amazon Web Services IoT
    /// FleetWise can encrypt your data and
    /// resources using an Amazon Web Services managed key. Or, you can use a KMS
    /// key that you own and
    /// manage. For more information, see [Data
    /// encryption](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/data-encryption.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn putEncryptionConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_encryption_configuration.PutEncryptionConfigurationInput, options: put_encryption_configuration.Options) !put_encryption_configuration.PutEncryptionConfigurationOutput {
        return put_encryption_configuration.execute(self, allocator, input, options);
    }

    /// Creates or updates the logging option.
    pub fn putLoggingOptions(self: *Self, allocator: std.mem.Allocator, input: put_logging_options.PutLoggingOptionsInput, options: put_logging_options.Options) !put_logging_options.PutLoggingOptionsOutput {
        return put_logging_options.execute(self, allocator, input, options);
    }

    /// This API operation contains deprecated parameters. Register your account
    /// again
    /// without the Timestream resources parameter so that Amazon Web Services IoT
    /// FleetWise can remove the Timestream
    /// metadata stored. You should then pass the data destination into the
    /// [CreateCampaign](https://docs.aws.amazon.com/iot-fleetwise/latest/APIReference/API_CreateCampaign.html) API operation.
    ///
    /// You must delete any existing campaigns that include an empty data
    /// destination
    /// before you register your account again. For more information, see the
    /// [DeleteCampaign](https://docs.aws.amazon.com/iot-fleetwise/latest/APIReference/API_DeleteCampaign.html) API operation.
    ///
    /// If you want to delete the Timestream inline policy from the service-linked
    /// role, such
    /// as to mitigate an overly permissive policy, you must first delete any
    /// existing
    /// campaigns. Then delete the service-linked role and register your account
    /// again to
    /// enable CloudWatch metrics. For more information, see
    /// [DeleteServiceLinkedRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteServiceLinkedRole.html) in the *Identity and Access Management API
    /// Reference*.
    ///
    /// Registers your Amazon Web Services account, IAM, and Amazon Timestream
    /// resources so Amazon Web Services IoT FleetWise can
    /// transfer your vehicle data to the Amazon Web Services Cloud. For more
    /// information, including
    /// step-by-step procedures, see [Setting up
    /// Amazon Web Services IoT
    /// FleetWise](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/setting-up.html).
    ///
    /// An Amazon Web Services account is **not** the same thing as a
    /// "user." An [Amazon Web Services
    /// user](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction_identity-management.html#intro-identity-users) is an identity that you create using Identity and Access Management (IAM) and
    /// takes the form of either an [IAM
    /// user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users.html) or an
    /// [IAM role, both
    /// with
    /// credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html). A single Amazon Web Services account can, and typically does,
    /// contain many users and roles.
    pub fn registerAccount(self: *Self, allocator: std.mem.Allocator, input: register_account.RegisterAccountInput, options: register_account.Options) !register_account.RegisterAccountOutput {
        return register_account.execute(self, allocator, input, options);
    }

    /// Adds to or modifies the tags of the given resource. Tags are metadata which
    /// can be
    /// used to manage a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the given tags (metadata) from the resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a campaign.
    pub fn updateCampaign(self: *Self, allocator: std.mem.Allocator, input: update_campaign.UpdateCampaignInput, options: update_campaign.Options) !update_campaign.UpdateCampaignOutput {
        return update_campaign.execute(self, allocator, input, options);
    }

    /// Updates a decoder manifest.
    ///
    /// A decoder manifest can only be updated when the status is `DRAFT`. Only
    /// `ACTIVE` decoder manifests can be associated with vehicles.
    pub fn updateDecoderManifest(self: *Self, allocator: std.mem.Allocator, input: update_decoder_manifest.UpdateDecoderManifestInput, options: update_decoder_manifest.Options) !update_decoder_manifest.UpdateDecoderManifestOutput {
        return update_decoder_manifest.execute(self, allocator, input, options);
    }

    /// Updates the description of an existing fleet.
    pub fn updateFleet(self: *Self, allocator: std.mem.Allocator, input: update_fleet.UpdateFleetInput, options: update_fleet.Options) !update_fleet.UpdateFleetOutput {
        return update_fleet.execute(self, allocator, input, options);
    }

    /// Updates a vehicle model (model manifest). If created vehicles are associated
    /// with a
    /// vehicle model, it can't be updated.
    pub fn updateModelManifest(self: *Self, allocator: std.mem.Allocator, input: update_model_manifest.UpdateModelManifestInput, options: update_model_manifest.Options) !update_model_manifest.UpdateModelManifestOutput {
        return update_model_manifest.execute(self, allocator, input, options);
    }

    /// Updates a signal catalog.
    pub fn updateSignalCatalog(self: *Self, allocator: std.mem.Allocator, input: update_signal_catalog.UpdateSignalCatalogInput, options: update_signal_catalog.Options) !update_signal_catalog.UpdateSignalCatalogOutput {
        return update_signal_catalog.execute(self, allocator, input, options);
    }

    /// Updates a state template.
    ///
    /// Access to certain Amazon Web Services IoT FleetWise features is currently
    /// gated. For more information, see [Amazon Web Services Region and feature
    /// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn updateStateTemplate(self: *Self, allocator: std.mem.Allocator, input: update_state_template.UpdateStateTemplateInput, options: update_state_template.Options) !update_state_template.UpdateStateTemplateOutput {
        return update_state_template.execute(self, allocator, input, options);
    }

    /// Updates a vehicle.
    ///
    /// Access to certain Amazon Web Services IoT FleetWise features is currently
    /// gated. For more information, see [Amazon Web Services Region and feature
    /// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
    pub fn updateVehicle(self: *Self, allocator: std.mem.Allocator, input: update_vehicle.UpdateVehicleInput, options: update_vehicle.Options) !update_vehicle.UpdateVehicleOutput {
        return update_vehicle.execute(self, allocator, input, options);
    }

    pub fn getVehicleStatusPaginator(self: *Self, params: get_vehicle_status.GetVehicleStatusInput) paginator.GetVehicleStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCampaignsPaginator(self: *Self, params: list_campaigns.ListCampaignsInput) paginator.ListCampaignsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDecoderManifestNetworkInterfacesPaginator(self: *Self, params: list_decoder_manifest_network_interfaces.ListDecoderManifestNetworkInterfacesInput) paginator.ListDecoderManifestNetworkInterfacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDecoderManifestSignalsPaginator(self: *Self, params: list_decoder_manifest_signals.ListDecoderManifestSignalsInput) paginator.ListDecoderManifestSignalsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDecoderManifestsPaginator(self: *Self, params: list_decoder_manifests.ListDecoderManifestsInput) paginator.ListDecoderManifestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFleetsPaginator(self: *Self, params: list_fleets.ListFleetsInput) paginator.ListFleetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFleetsForVehiclePaginator(self: *Self, params: list_fleets_for_vehicle.ListFleetsForVehicleInput) paginator.ListFleetsForVehiclePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelManifestNodesPaginator(self: *Self, params: list_model_manifest_nodes.ListModelManifestNodesInput) paginator.ListModelManifestNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelManifestsPaginator(self: *Self, params: list_model_manifests.ListModelManifestsInput) paginator.ListModelManifestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSignalCatalogNodesPaginator(self: *Self, params: list_signal_catalog_nodes.ListSignalCatalogNodesInput) paginator.ListSignalCatalogNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSignalCatalogsPaginator(self: *Self, params: list_signal_catalogs.ListSignalCatalogsInput) paginator.ListSignalCatalogsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStateTemplatesPaginator(self: *Self, params: list_state_templates.ListStateTemplatesInput) paginator.ListStateTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVehiclesPaginator(self: *Self, params: list_vehicles.ListVehiclesInput) paginator.ListVehiclesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listVehiclesInFleetPaginator(self: *Self, params: list_vehicles_in_fleet.ListVehiclesInFleetInput) paginator.ListVehiclesInFleetPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
