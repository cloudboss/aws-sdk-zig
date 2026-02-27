const aws = @import("aws");
const std = @import("std");

const associate_tracker_consumer = @import("associate_tracker_consumer.zig");
const batch_delete_device_position_history = @import("batch_delete_device_position_history.zig");
const batch_delete_geofence = @import("batch_delete_geofence.zig");
const batch_evaluate_geofences = @import("batch_evaluate_geofences.zig");
const batch_get_device_position = @import("batch_get_device_position.zig");
const batch_put_geofence = @import("batch_put_geofence.zig");
const batch_update_device_position = @import("batch_update_device_position.zig");
const calculate_route = @import("calculate_route.zig");
const calculate_route_matrix = @import("calculate_route_matrix.zig");
const create_geofence_collection = @import("create_geofence_collection.zig");
const create_key = @import("create_key.zig");
const create_map = @import("create_map.zig");
const create_place_index = @import("create_place_index.zig");
const create_route_calculator = @import("create_route_calculator.zig");
const create_tracker = @import("create_tracker.zig");
const delete_geofence_collection = @import("delete_geofence_collection.zig");
const delete_key = @import("delete_key.zig");
const delete_map = @import("delete_map.zig");
const delete_place_index = @import("delete_place_index.zig");
const delete_route_calculator = @import("delete_route_calculator.zig");
const delete_tracker = @import("delete_tracker.zig");
const describe_geofence_collection = @import("describe_geofence_collection.zig");
const describe_key = @import("describe_key.zig");
const describe_map = @import("describe_map.zig");
const describe_place_index = @import("describe_place_index.zig");
const describe_route_calculator = @import("describe_route_calculator.zig");
const describe_tracker = @import("describe_tracker.zig");
const disassociate_tracker_consumer = @import("disassociate_tracker_consumer.zig");
const forecast_geofence_events = @import("forecast_geofence_events.zig");
const get_device_position = @import("get_device_position.zig");
const get_device_position_history = @import("get_device_position_history.zig");
const get_geofence = @import("get_geofence.zig");
const get_map_glyphs = @import("get_map_glyphs.zig");
const get_map_sprites = @import("get_map_sprites.zig");
const get_map_style_descriptor = @import("get_map_style_descriptor.zig");
const get_map_tile = @import("get_map_tile.zig");
const get_place = @import("get_place.zig");
const list_device_positions = @import("list_device_positions.zig");
const list_geofence_collections = @import("list_geofence_collections.zig");
const list_geofences = @import("list_geofences.zig");
const list_keys = @import("list_keys.zig");
const list_maps = @import("list_maps.zig");
const list_place_indexes = @import("list_place_indexes.zig");
const list_route_calculators = @import("list_route_calculators.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tracker_consumers = @import("list_tracker_consumers.zig");
const list_trackers = @import("list_trackers.zig");
const put_geofence = @import("put_geofence.zig");
const search_place_index_for_position = @import("search_place_index_for_position.zig");
const search_place_index_for_suggestions = @import("search_place_index_for_suggestions.zig");
const search_place_index_for_text = @import("search_place_index_for_text.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_geofence_collection = @import("update_geofence_collection.zig");
const update_key = @import("update_key.zig");
const update_map = @import("update_map.zig");
const update_place_index = @import("update_place_index.zig");
const update_route_calculator = @import("update_route_calculator.zig");
const update_tracker = @import("update_tracker.zig");
const verify_device_position = @import("verify_device_position.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Location";

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

    /// Creates an association between a geofence collection and a tracker resource.
    /// This allows the tracker resource to communicate location data to the linked
    /// geofence collection.
    ///
    /// You can associate up to five geofence collections to each tracker resource.
    ///
    /// Currently not supported — Cross-account configurations, such as creating
    /// associations between a tracker resource in one account and a geofence
    /// collection in another account.
    pub fn associateTrackerConsumer(self: *Self, allocator: std.mem.Allocator, input: associate_tracker_consumer.AssociateTrackerConsumerInput, options: associate_tracker_consumer.Options) !associate_tracker_consumer.AssociateTrackerConsumerOutput {
        return associate_tracker_consumer.execute(self, allocator, input, options);
    }

    /// Deletes the position history of one or more devices from a tracker resource.
    pub fn batchDeleteDevicePositionHistory(self: *Self, allocator: std.mem.Allocator, input: batch_delete_device_position_history.BatchDeleteDevicePositionHistoryInput, options: batch_delete_device_position_history.Options) !batch_delete_device_position_history.BatchDeleteDevicePositionHistoryOutput {
        return batch_delete_device_position_history.execute(self, allocator, input, options);
    }

    /// Deletes a batch of geofences from a geofence collection.
    ///
    /// This operation deletes the resource permanently.
    pub fn batchDeleteGeofence(self: *Self, allocator: std.mem.Allocator, input: batch_delete_geofence.BatchDeleteGeofenceInput, options: batch_delete_geofence.Options) !batch_delete_geofence.BatchDeleteGeofenceOutput {
        return batch_delete_geofence.execute(self, allocator, input, options);
    }

    /// Evaluates device positions against the geofence geometries from a given
    /// geofence collection.
    ///
    /// This operation always returns an empty response because geofences are
    /// asynchronously evaluated. The evaluation determines if the device has
    /// entered or exited a geofenced area, and then publishes one of the following
    /// events to Amazon EventBridge:
    ///
    /// * `ENTER` if Amazon Location determines that the tracked device has entered
    ///   a geofenced area.
    /// * `EXIT` if Amazon Location determines that the tracked device has exited a
    ///   geofenced area.
    ///
    /// The last geofence that a device was observed within is tracked for 30 days
    /// after the most recent device position update.
    ///
    /// Geofence evaluation uses the given device position. It does not account for
    /// the optional `Accuracy` of a `DevicePositionUpdate`.
    ///
    /// The `DeviceID` is used as a string to represent the device. You do not need
    /// to have a `Tracker` associated with the `DeviceID`.
    pub fn batchEvaluateGeofences(self: *Self, allocator: std.mem.Allocator, input: batch_evaluate_geofences.BatchEvaluateGeofencesInput, options: batch_evaluate_geofences.Options) !batch_evaluate_geofences.BatchEvaluateGeofencesOutput {
        return batch_evaluate_geofences.execute(self, allocator, input, options);
    }

    /// Lists the latest device positions for requested devices.
    pub fn batchGetDevicePosition(self: *Self, allocator: std.mem.Allocator, input: batch_get_device_position.BatchGetDevicePositionInput, options: batch_get_device_position.Options) !batch_get_device_position.BatchGetDevicePositionOutput {
        return batch_get_device_position.execute(self, allocator, input, options);
    }

    /// A batch request for storing geofence geometries into a given geofence
    /// collection, or updates the geometry of an existing geofence if a geofence ID
    /// is included in the request.
    pub fn batchPutGeofence(self: *Self, allocator: std.mem.Allocator, input: batch_put_geofence.BatchPutGeofenceInput, options: batch_put_geofence.Options) !batch_put_geofence.BatchPutGeofenceOutput {
        return batch_put_geofence.execute(self, allocator, input, options);
    }

    /// Uploads position update data for one or more devices to a tracker resource
    /// (up to 10 devices per batch). Amazon Location uses the data when it reports
    /// the last known device position and position history. Amazon Location retains
    /// location data for 30 days.
    ///
    /// Position updates are handled based on the `PositionFiltering` property of
    /// the tracker. When `PositionFiltering` is set to `TimeBased`, updates are
    /// evaluated against linked geofence collections, and location data is stored
    /// at a maximum of one position per 30 second interval. If your update
    /// frequency is more often than every 30 seconds, only one update per 30
    /// seconds is stored for each unique device ID.
    ///
    /// When `PositionFiltering` is set to `DistanceBased` filtering, location data
    /// is stored and evaluated against linked geofence collections only if the
    /// device has moved more than 30 m (98.4 ft).
    ///
    /// When `PositionFiltering` is set to `AccuracyBased` filtering, location data
    /// is stored and evaluated against linked geofence collections only if the
    /// device has moved more than the measured accuracy. For example, if two
    /// consecutive updates from a device have a horizontal accuracy of 5 m and 10
    /// m, the second update is neither stored or evaluated if the device has moved
    /// less than 15 m. If `PositionFiltering` is set to `AccuracyBased` filtering,
    /// Amazon Location uses the default value `{ "Horizontal": 0}` when accuracy is
    /// not provided on a `DevicePositionUpdate`.
    pub fn batchUpdateDevicePosition(self: *Self, allocator: std.mem.Allocator, input: batch_update_device_position.BatchUpdateDevicePositionInput, options: batch_update_device_position.Options) !batch_update_device_position.BatchUpdateDevicePositionOutput {
        return batch_update_device_position.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to [ `CalculateRoutes`
    /// ](/location/latest/APIReference/API_CalculateRoutes.html) or [
    /// `CalculateIsolines`
    /// ](/location/latest/APIReference/API_CalculateIsolines.html) unless you
    /// require Grab data.
    ///
    /// * `CalculateRoute` is part of a previous Amazon Location Service Routes API
    ///   (version 1) which has been superseded by a more intuitive, powerful, and
    ///   complete API (version 2).
    /// * The version 2 `CalculateRoutes` operation gives better results for
    ///   point-to-point routing, while the version 2 `CalculateIsolines` operation
    ///   adds support for calculating service areas and travel time envelopes.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Routes API version 2 is found under `geo-routes` or
    ///   `geo_routes`, not under `location`.
    /// * Since Grab is not yet fully supported in Routes API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    ///
    /// [Calculates a
    /// route](https://docs.aws.amazon.com/location/previous/developerguide/calculate-route.html) given the following required parameters: `DeparturePosition` and `DestinationPosition`. Requires that you first [create a route calculator resource](https://docs.aws.amazon.com/location-routes/latest/APIReference/API_CreateRouteCalculator.html).
    ///
    /// By default, a request that doesn't specify a departure time uses the best
    /// time of day to travel with the best traffic conditions when calculating the
    /// route.
    ///
    /// Additional options include:
    ///
    /// * [Specifying a departure
    ///   time](https://docs.aws.amazon.com/location/previous/developerguide/departure-time.html) using either `DepartureTime` or `DepartNow`. This calculates a route based on predictive traffic data at the given time.
    ///
    /// You can't specify both `DepartureTime` and `DepartNow` in a single request.
    /// Specifying both parameters returns a validation error.
    /// * [Specifying a travel
    ///   mode](https://docs.aws.amazon.com/location/previous/developerguide/travel-mode.html) using TravelMode sets the transportation mode used to calculate the routes. This also lets you specify additional route preferences in `CarModeOptions` if traveling by `Car`, or `TruckModeOptions` if traveling by `Truck`.
    ///
    /// If you specify `walking` for the travel mode and your data provider is Esri,
    /// the start and destination must be within 40km.
    pub fn calculateRoute(self: *Self, allocator: std.mem.Allocator, input: calculate_route.CalculateRouteInput, options: calculate_route.Options) !calculate_route.CalculateRouteOutput {
        return calculate_route.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the [V2 `CalculateRouteMatrix`
    /// ](/location/latest/APIReference/API_CalculateRouteMatrix.html) unless you
    /// require Grab data.
    ///
    /// * This version of `CalculateRouteMatrix` is part of a previous Amazon
    ///   Location Service Routes API (version 1) which has been superseded by a
    ///   more intuitive, powerful, and complete API (version 2).
    /// * The version 2 `CalculateRouteMatrix` operation gives better results for
    ///   matrix routing calculations.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Routes API version 2 is found under `geo-routes` or
    ///   `geo_routes`, not under `location`.
    /// * Since Grab is not yet fully supported in Routes API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Routes V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Routes_V2.html) or the [Developer Guide](/location/latest/developerguide/routes.html).
    ///
    /// [ Calculates a route
    /// matrix](https://docs.aws.amazon.com/location/previous/developerguide/calculate-route-matrix.html) given the following required parameters: `DeparturePositions` and `DestinationPositions`. `CalculateRouteMatrix` calculates routes and returns the travel time and travel distance from each departure position to each destination position in the request. For example, given departure positions A and B, and destination positions X and Y, `CalculateRouteMatrix` will return time and distance for routes from A to X, A to Y, B to X, and B to Y (in that order). The number of results returned (and routes calculated) will be the number of `DeparturePositions` times the number of `DestinationPositions`.
    ///
    /// Your account is charged for each route calculated, not the number of
    /// requests.
    ///
    /// Requires that you first [create a route calculator
    /// resource](https://docs.aws.amazon.com/location-routes/latest/APIReference/API_CreateRouteCalculator.html).
    ///
    /// By default, a request that doesn't specify a departure time uses the best
    /// time of day to travel with the best traffic conditions when calculating
    /// routes.
    ///
    /// Additional options include:
    ///
    /// * [ Specifying a departure
    ///   time](https://docs.aws.amazon.com/location/previous/developerguide/departure-time.html) using either `DepartureTime` or `DepartNow`. This calculates routes based on predictive traffic data at the given time.
    ///
    /// You can't specify both `DepartureTime` and `DepartNow` in a single request.
    /// Specifying both parameters returns a validation error.
    /// * [Specifying a travel
    ///   mode](https://docs.aws.amazon.com/location/previous/developerguide/travel-mode.html) using TravelMode sets the transportation mode used to calculate the routes. This also lets you specify additional route preferences in `CarModeOptions` if traveling by `Car`, or `TruckModeOptions` if traveling by `Truck`.
    pub fn calculateRouteMatrix(self: *Self, allocator: std.mem.Allocator, input: calculate_route_matrix.CalculateRouteMatrixInput, options: calculate_route_matrix.Options) !calculate_route_matrix.CalculateRouteMatrixOutput {
        return calculate_route_matrix.execute(self, allocator, input, options);
    }

    /// Creates a geofence collection, which manages and stores geofences.
    pub fn createGeofenceCollection(self: *Self, allocator: std.mem.Allocator, input: create_geofence_collection.CreateGeofenceCollectionInput, options: create_geofence_collection.Options) !create_geofence_collection.CreateGeofenceCollectionOutput {
        return create_geofence_collection.execute(self, allocator, input, options);
    }

    /// Creates an API key resource in your Amazon Web Services account, which lets
    /// you grant actions for Amazon Location resources to the API key bearer.
    ///
    /// For more information, see [Use API keys to
    /// authenticate](https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html) in the *Amazon Location Service Developer Guide*.
    pub fn createKey(self: *Self, allocator: std.mem.Allocator, input: create_key.CreateKeyInput, options: create_key.Options) !create_key.CreateKeyOutput {
        return create_key.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend upgrading to the Maps API V2 unless you require `Grab` data.
    ///
    /// * `CreateMap` is part of a previous Amazon Location Service Maps API
    ///   (version 1) which has been superseded by a more intuitive, powerful, and
    ///   complete API (version 2).
    /// * The Maps API version 2 has a simplified interface that can be used without
    ///   creating or managing map resources.
    /// * If you are using an AWS SDK or the AWS CLI, note that the Maps API version
    ///   2 is found under `geo-maps` or `geo_maps`, not under `location`.
    /// * Since `Grab` is not yet fully supported in Maps API version 2, we
    ///   recommend you continue using API version 1 when using `Grab`.
    /// * Start your version 2 API journey with the [Maps V2 API
    ///   Reference](https://docs.aws.amazon.com/location/latest/APIReference/API_Operations_Amazon_Location_Service_Maps_V2.html) or the [Developer Guide](https://docs.aws.amazon.com/location/latest/developerguide/maps.html).
    ///
    /// Creates a map resource in your Amazon Web Services account, which provides
    /// map tiles of different styles sourced from global location data providers.
    ///
    /// If your application is tracking or routing assets you use in your business,
    /// such as delivery vehicles or employees, you must not use Esri as your
    /// geolocation provider. See section 82 of the [Amazon Web Services service
    /// terms](http://aws.amazon.com/service-terms) for more details.
    pub fn createMap(self: *Self, allocator: std.mem.Allocator, input: create_map.CreateMapInput, options: create_map.Options) !create_map.CreateMapOutput {
        return create_map.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the Places API V2 unless you require Grab data.
    ///
    /// * `CreatePlaceIndex` is part of a previous Amazon Location Service Places
    ///   API (version 1) which has been superseded by a more intuitive, powerful,
    ///   and complete API (version 2).
    /// * The Places API version 2 has a simplified interface that can be used
    ///   without creating or managing place index resources.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Places API version 2 is found under `geo-places` or
    ///   `geo_places`, not under `location`.
    /// * Since Grab is not yet fully supported in Places API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Places V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Places_V2.html) or the [Developer Guide](/location/latest/developerguide/places.html).
    ///
    /// Creates a place index resource in your Amazon Web Services account. Use a
    /// place index resource to geocode addresses and other text queries by using
    /// the `SearchPlaceIndexForText` operation, and reverse geocode coordinates by
    /// using the `SearchPlaceIndexForPosition` operation, and enable
    /// autosuggestions by using the `SearchPlaceIndexForSuggestions` operation.
    ///
    /// If your application is tracking or routing assets you use in your business,
    /// such as delivery vehicles or employees, you must not use Esri as your
    /// geolocation provider. See section 82 of the [Amazon Web Services service
    /// terms](http://aws.amazon.com/service-terms) for more details.
    pub fn createPlaceIndex(self: *Self, allocator: std.mem.Allocator, input: create_place_index.CreatePlaceIndexInput, options: create_place_index.Options) !create_place_index.CreatePlaceIndexOutput {
        return create_place_index.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the Routes API V2 unless you require Grab data.
    ///
    /// * `CreateRouteCalculator` is part of a previous Amazon Location Service
    ///   Routes API (version 1) which has been superseded by a more intuitive,
    ///   powerful, and complete API (version 2).
    /// * The Routes API version 2 has a simplified interface that can be used
    ///   without creating or managing route calculator resources.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Routes API version 2 is found under `geo-routes` or
    ///   `geo_routes`, not under `location`.
    /// * Since Grab is not yet fully supported in Routes API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Routes V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Routes_V2.html) or the [Developer Guide](/location/latest/developerguide/routes.html).
    ///
    /// Creates a route calculator resource in your Amazon Web Services account.
    ///
    /// You can send requests to a route calculator resource to estimate travel
    /// time, distance, and get directions. A route calculator sources traffic and
    /// road network data from your chosen data provider.
    ///
    /// If your application is tracking or routing assets you use in your business,
    /// such as delivery vehicles or employees, you must not use Esri as your
    /// geolocation provider. See section 82 of the [Amazon Web Services service
    /// terms](http://aws.amazon.com/service-terms) for more details.
    pub fn createRouteCalculator(self: *Self, allocator: std.mem.Allocator, input: create_route_calculator.CreateRouteCalculatorInput, options: create_route_calculator.Options) !create_route_calculator.CreateRouteCalculatorOutput {
        return create_route_calculator.execute(self, allocator, input, options);
    }

    /// Creates a tracker resource in your Amazon Web Services account, which lets
    /// you retrieve current and historical location of devices.
    pub fn createTracker(self: *Self, allocator: std.mem.Allocator, input: create_tracker.CreateTrackerInput, options: create_tracker.Options) !create_tracker.CreateTrackerOutput {
        return create_tracker.execute(self, allocator, input, options);
    }

    /// Deletes a geofence collection from your Amazon Web Services account.
    ///
    /// This operation deletes the resource permanently. If the geofence collection
    /// is the target of a tracker resource, the devices will no longer be
    /// monitored.
    pub fn deleteGeofenceCollection(self: *Self, allocator: std.mem.Allocator, input: delete_geofence_collection.DeleteGeofenceCollectionInput, options: delete_geofence_collection.Options) !delete_geofence_collection.DeleteGeofenceCollectionOutput {
        return delete_geofence_collection.execute(self, allocator, input, options);
    }

    /// Deletes the specified API key. The API key must have been deactivated more
    /// than 90 days previously.
    ///
    /// For more information, see [Use API keys to
    /// authenticate](https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html) in the *Amazon Location Service Developer Guide*.
    pub fn deleteKey(self: *Self, allocator: std.mem.Allocator, input: delete_key.DeleteKeyInput, options: delete_key.Options) !delete_key.DeleteKeyOutput {
        return delete_key.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend upgrading to the Maps API V2 unless you require `Grab` data.
    ///
    /// * `DeleteMap` is part of a previous Amazon Location Service Maps API
    ///   (version 1) which has been superseded by a more intuitive, powerful, and
    ///   complete API (version 2).
    /// * The Maps API version 2 has a simplified interface that can be used without
    ///   creating or managing map resources.
    /// * If you are using an AWS SDK or the AWS CLI, note that the Maps API version
    ///   2 is found under `geo-maps` or `geo_maps`, not under `location`.
    /// * Since `Grab` is not yet fully supported in Maps API version 2, we
    ///   recommend you continue using API version 1 when using `Grab`.
    /// * Start your version 2 API journey with the [Maps V2 API
    ///   Reference](https://docs.aws.amazon.com/location/latest/APIReference/API_Operations_Amazon_Location_Service_Maps_V2.html) or the [Developer Guide](https://docs.aws.amazon.com/location/latest/developerguide/maps.html).
    ///
    /// Deletes a map resource from your Amazon Web Services account.
    ///
    /// This operation deletes the resource permanently. If the map is being used in
    /// an application, the map may not render.
    pub fn deleteMap(self: *Self, allocator: std.mem.Allocator, input: delete_map.DeleteMapInput, options: delete_map.Options) !delete_map.DeleteMapOutput {
        return delete_map.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the Places API V2 unless you require Grab data.
    ///
    /// * `DeletePlaceIndex` is part of a previous Amazon Location Service Places
    ///   API (version 1) which has been superseded by a more intuitive, powerful,
    ///   and complete API (version 2).
    /// * The Places API version 2 has a simplified interface that can be used
    ///   without creating or managing place index resources.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Places API version 2 is found under `geo-places` or
    ///   `geo_places`, not under `location`.
    /// * Since Grab is not yet fully supported in Places API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Places V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Places_V2.html) or the [Developer Guide](/location/latest/developerguide/places.html).
    ///
    /// Deletes a place index resource from your Amazon Web Services account.
    ///
    /// This operation deletes the resource permanently.
    pub fn deletePlaceIndex(self: *Self, allocator: std.mem.Allocator, input: delete_place_index.DeletePlaceIndexInput, options: delete_place_index.Options) !delete_place_index.DeletePlaceIndexOutput {
        return delete_place_index.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the Routes API V2 unless you require Grab data.
    ///
    /// * `DeleteRouteCalculator` is part of a previous Amazon Location Service
    ///   Routes API (version 1) which has been superseded by a more intuitive,
    ///   powerful, and complete API (version 2).
    /// * The Routes API version 2 has a simplified interface that can be used
    ///   without creating or managing route calculator resources.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Routes API version 2 is found under `geo-routes` or
    ///   `geo_routes`, not under `location`.
    /// * Since Grab is not yet fully supported in Routes API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Routes V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Routes_V2.html) or the [Developer Guide](/location/latest/developerguide/routes.html).
    ///
    /// Deletes a route calculator resource from your Amazon Web Services account.
    ///
    /// This operation deletes the resource permanently.
    pub fn deleteRouteCalculator(self: *Self, allocator: std.mem.Allocator, input: delete_route_calculator.DeleteRouteCalculatorInput, options: delete_route_calculator.Options) !delete_route_calculator.DeleteRouteCalculatorOutput {
        return delete_route_calculator.execute(self, allocator, input, options);
    }

    /// Deletes a tracker resource from your Amazon Web Services account.
    ///
    /// This operation deletes the resource permanently. If the tracker resource is
    /// in use, you may encounter an error. Make sure that the target resource isn't
    /// a dependency for your applications.
    pub fn deleteTracker(self: *Self, allocator: std.mem.Allocator, input: delete_tracker.DeleteTrackerInput, options: delete_tracker.Options) !delete_tracker.DeleteTrackerOutput {
        return delete_tracker.execute(self, allocator, input, options);
    }

    /// Retrieves the geofence collection details.
    pub fn describeGeofenceCollection(self: *Self, allocator: std.mem.Allocator, input: describe_geofence_collection.DescribeGeofenceCollectionInput, options: describe_geofence_collection.Options) !describe_geofence_collection.DescribeGeofenceCollectionOutput {
        return describe_geofence_collection.execute(self, allocator, input, options);
    }

    /// Retrieves the API key resource details.
    ///
    /// For more information, see [Use API keys to
    /// authenticate](https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html) in the *Amazon Location Service Developer Guide*.
    pub fn describeKey(self: *Self, allocator: std.mem.Allocator, input: describe_key.DescribeKeyInput, options: describe_key.Options) !describe_key.DescribeKeyOutput {
        return describe_key.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend upgrading to the Maps API V2 unless you require `Grab` data.
    ///
    /// * `DescribeMap` is part of a previous Amazon Location Service Maps API
    ///   (version 1) which has been superseded by a more intuitive, powerful, and
    ///   complete API (version 2).
    /// * The Maps API version 2 has a simplified interface that can be used without
    ///   creating or managing map resources.
    /// * If you are using an AWS SDK or the AWS CLI, note that the Maps API version
    ///   2 is found under `geo-maps` or `geo_maps`, not under `location`.
    /// * Since `Grab` is not yet fully supported in Maps API version 2, we
    ///   recommend you continue using API version 1 when using `Grab`.
    /// * Start your version 2 API journey with the [Maps V2 API
    ///   Reference](https://docs.aws.amazon.com/location/latest/APIReference/API_Operations_Amazon_Location_Service_Maps_V2.html) or the [Developer Guide](https://docs.aws.amazon.com/location/latest/developerguide/maps.html).
    ///
    /// Retrieves the map resource details.
    pub fn describeMap(self: *Self, allocator: std.mem.Allocator, input: describe_map.DescribeMapInput, options: describe_map.Options) !describe_map.DescribeMapOutput {
        return describe_map.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the Places API V2 unless you require Grab data.
    ///
    /// * `DescribePlaceIndex` is part of a previous Amazon Location Service Places
    ///   API (version 1) which has been superseded by a more intuitive, powerful,
    ///   and complete API (version 2).
    /// * The Places API version 2 has a simplified interface that can be used
    ///   without creating or managing place index resources.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Places API version 2 is found under `geo-places` or
    ///   `geo_places`, not under `location`.
    /// * Since Grab is not yet fully supported in Places API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Places V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Places_V2.html) or the [Developer Guide](/location/latest/developerguide/places.html).
    ///
    /// Retrieves the place index resource details.
    pub fn describePlaceIndex(self: *Self, allocator: std.mem.Allocator, input: describe_place_index.DescribePlaceIndexInput, options: describe_place_index.Options) !describe_place_index.DescribePlaceIndexOutput {
        return describe_place_index.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the Routes API V2 unless you require Grab data.
    ///
    /// * `DescribeRouteCalculator` is part of a previous Amazon Location Service
    ///   Routes API (version 1) which has been superseded by a more intuitive,
    ///   powerful, and complete API (version 2).
    /// * The Routes API version 2 has a simplified interface that can be used
    ///   without creating or managing route calculator resources.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Routes API version 2 is found under `geo-routes` or
    ///   `geo_routes`, not under `location`.
    /// * Since Grab is not yet fully supported in Routes API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Routes V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Routes_V2.html) or the [Developer Guide](/location/latest/developerguide/routes.html).
    ///
    /// Retrieves the route calculator resource details.
    pub fn describeRouteCalculator(self: *Self, allocator: std.mem.Allocator, input: describe_route_calculator.DescribeRouteCalculatorInput, options: describe_route_calculator.Options) !describe_route_calculator.DescribeRouteCalculatorOutput {
        return describe_route_calculator.execute(self, allocator, input, options);
    }

    /// Retrieves the tracker resource details.
    pub fn describeTracker(self: *Self, allocator: std.mem.Allocator, input: describe_tracker.DescribeTrackerInput, options: describe_tracker.Options) !describe_tracker.DescribeTrackerOutput {
        return describe_tracker.execute(self, allocator, input, options);
    }

    /// Removes the association between a tracker resource and a geofence
    /// collection.
    ///
    /// Once you unlink a tracker resource from a geofence collection, the tracker
    /// positions will no longer be automatically evaluated against geofences.
    pub fn disassociateTrackerConsumer(self: *Self, allocator: std.mem.Allocator, input: disassociate_tracker_consumer.DisassociateTrackerConsumerInput, options: disassociate_tracker_consumer.Options) !disassociate_tracker_consumer.DisassociateTrackerConsumerOutput {
        return disassociate_tracker_consumer.execute(self, allocator, input, options);
    }

    /// This action forecasts future geofence events that are likely to occur within
    /// a specified time horizon if a device continues moving at its current speed.
    /// Each forecasted event is associated with a geofence from a provided geofence
    /// collection. A forecast event can have one of the following states:
    ///
    /// `ENTER`: The device position is outside the referenced geofence, but the
    /// device may cross into the geofence during the forecasting time horizon if it
    /// maintains its current speed.
    ///
    /// `EXIT`: The device position is inside the referenced geofence, but the
    /// device may leave the geofence during the forecasted time horizon if the
    /// device maintains it's current speed.
    ///
    /// `IDLE`:The device is inside the geofence, and it will remain inside the
    /// geofence through the end of the time horizon if the device maintains it's
    /// current speed.
    ///
    /// Heading direction is not considered in the current version. The API takes a
    /// conservative approach and includes events that can occur for any heading.
    pub fn forecastGeofenceEvents(self: *Self, allocator: std.mem.Allocator, input: forecast_geofence_events.ForecastGeofenceEventsInput, options: forecast_geofence_events.Options) !forecast_geofence_events.ForecastGeofenceEventsOutput {
        return forecast_geofence_events.execute(self, allocator, input, options);
    }

    /// Retrieves a device's most recent position according to its sample time.
    ///
    /// Device positions are deleted after 30 days.
    pub fn getDevicePosition(self: *Self, allocator: std.mem.Allocator, input: get_device_position.GetDevicePositionInput, options: get_device_position.Options) !get_device_position.GetDevicePositionOutput {
        return get_device_position.execute(self, allocator, input, options);
    }

    /// Retrieves the device position history from a tracker resource within a
    /// specified range of time.
    ///
    /// Device positions are deleted after 30 days.
    pub fn getDevicePositionHistory(self: *Self, allocator: std.mem.Allocator, input: get_device_position_history.GetDevicePositionHistoryInput, options: get_device_position_history.Options) !get_device_position_history.GetDevicePositionHistoryOutput {
        return get_device_position_history.execute(self, allocator, input, options);
    }

    /// Retrieves the geofence details from a geofence collection.
    ///
    /// The returned geometry will always match the geometry format used when the
    /// geofence was created.
    pub fn getGeofence(self: *Self, allocator: std.mem.Allocator, input: get_geofence.GetGeofenceInput, options: get_geofence.Options) !get_geofence.GetGeofenceOutput {
        return get_geofence.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend upgrading to [ `GetGlyphs`
    /// ](https://docs.aws.amazon.com/location/latest/APIReference/API_geomaps_GetGlyphs.html) unless you require `Grab` data.
    ///
    /// * `GetMapGlyphs` is part of a previous Amazon Location Service Maps API
    ///   (version 1) which has been superseded by a more intuitive, powerful, and
    ///   complete API (version 2).
    /// * The version 2 `GetGlyphs` operation gives a better user experience and is
    ///   compatible with the remainder of the V2 Maps API.
    /// * If you are using an AWS SDK or the AWS CLI, note that the Maps API version
    ///   2 is found under `geo-maps` or `geo_maps`, not under `location`.
    /// * Since `Grab` is not yet fully supported in Maps API version 2, we
    ///   recommend you continue using API version 1 when using `Grab`.
    /// * Start your version 2 API journey with the [Maps V2 API
    ///   Reference](https://docs.aws.amazon.com/location/latest/APIReference/API_Operations_Amazon_Location_Service_Maps_V2.html) or the [Developer Guide](https://docs.aws.amazon.com/location/latest/developerguide/maps.html).
    ///
    /// Retrieves glyphs used to display labels on a map.
    pub fn getMapGlyphs(self: *Self, allocator: std.mem.Allocator, input: get_map_glyphs.GetMapGlyphsInput, options: get_map_glyphs.Options) !get_map_glyphs.GetMapGlyphsOutput {
        return get_map_glyphs.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend upgrading to [ `GetSprites`
    /// ](https://docs.aws.amazon.com/location/latest/APIReference/API_geomaps_GetSprites.html) unless you require `Grab` data.
    ///
    /// * `GetMapSprites` is part of a previous Amazon Location Service Maps API
    ///   (version 1) which has been superseded by a more intuitive, powerful, and
    ///   complete API (version 2).
    /// * The version 2 `GetSprites` operation gives a better user experience and is
    ///   compatible with the remainder of the V2 Maps API.
    /// * If you are using an AWS SDK or the AWS CLI, note that the Maps API version
    ///   2 is found under `geo-maps` or `geo_maps`, not under `location`.
    /// * Since `Grab` is not yet fully supported in Maps API version 2, we
    ///   recommend you continue using API version 1 when using `Grab`.
    /// * Start your version 2 API journey with the [Maps V2 API
    ///   Reference](https://docs.aws.amazon.com/location/latest/APIReference/API_Operations_Amazon_Location_Service_Maps_V2.html) or the [Developer Guide](https://docs.aws.amazon.com/location/latest/developerguide/maps.html).
    ///
    /// Retrieves the sprite sheet corresponding to a map resource. The sprite sheet
    /// is a PNG image paired with a JSON document describing the offsets of
    /// individual icons that will be displayed on a rendered map.
    pub fn getMapSprites(self: *Self, allocator: std.mem.Allocator, input: get_map_sprites.GetMapSpritesInput, options: get_map_sprites.Options) !get_map_sprites.GetMapSpritesOutput {
        return get_map_sprites.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend upgrading to [ `GetStyleDescriptor`
    /// ](https://docs.aws.amazon.com/location/latest/APIReference/API_geomaps_GetStyleDescriptor.html) unless you require `Grab` data.
    ///
    /// * `GetMapStyleDescriptor` is part of a previous Amazon Location Service Maps
    ///   API (version 1) which has been superseded by a more intuitive, powerful,
    ///   and complete API (version 2).
    /// * The version 2 `GetStyleDescriptor` operation gives a better user
    ///   experience and is compatible with the remainder of the V2 Maps API.
    /// * If you are using an AWS SDK or the AWS CLI, note that the Maps API version
    ///   2 is found under `geo-maps` or `geo_maps`, not under `location`.
    /// * Since `Grab` is not yet fully supported in Maps API version 2, we
    ///   recommend you continue using API version 1 when using `Grab`.
    /// * Start your version 2 API journey with the [Maps V2 API
    ///   Reference](https://docs.aws.amazon.com/location/latest/APIReference/API_Operations_Amazon_Location_Service_Maps_V2.html) or the [Developer Guide](https://docs.aws.amazon.com/location/latest/developerguide/maps.html).
    ///
    /// Retrieves the map style descriptor from a map resource.
    ///
    /// The style descriptor contains speciﬁcations on how features render on a map.
    /// For example, what data to display, what order to display the data in, and
    /// the style for the data. Style descriptors follow the Mapbox Style
    /// Specification.
    pub fn getMapStyleDescriptor(self: *Self, allocator: std.mem.Allocator, input: get_map_style_descriptor.GetMapStyleDescriptorInput, options: get_map_style_descriptor.Options) !get_map_style_descriptor.GetMapStyleDescriptorOutput {
        return get_map_style_descriptor.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend upgrading to [ `GetTile`
    /// ](https://docs.aws.amazon.com/location/latest/APIReference/API_geomaps_GetTile.html) unless you require `Grab` data.
    ///
    /// * `GetMapTile` is part of a previous Amazon Location Service Maps API
    ///   (version 1) which has been superseded by a more intuitive, powerful, and
    ///   complete API (version 2).
    /// * The version 2 `GetTile` operation gives a better user experience and is
    ///   compatible with the remainder of the V2 Maps API.
    /// * If you are using an AWS SDK or the AWS CLI, note that the Maps API version
    ///   2 is found under `geo-maps` or `geo_maps`, not under `location`.
    /// * Since `Grab` is not yet fully supported in Maps API version 2, we
    ///   recommend you continue using API version 1 when using `Grab`.
    /// * Start your version 2 API journey with the [Maps V2 API
    ///   Reference](https://docs.aws.amazon.com/location/latest/APIReference/API_Operations_Amazon_Location_Service_Maps_V2.html) or the [Developer Guide](https://docs.aws.amazon.com/location/latest/developerguide/maps.html).
    ///
    /// Retrieves a vector data tile from the map resource. Map tiles are used by
    /// clients to render a map. they're addressed using a grid arrangement with an
    /// X coordinate, Y coordinate, and Z (zoom) level.
    ///
    /// The origin (0, 0) is the top left of the map. Increasing the zoom level by 1
    /// doubles both the X and Y dimensions, so a tile containing data for the
    /// entire world at (0/0/0) will be split into 4 tiles at zoom 1 (1/0/0, 1/0/1,
    /// 1/1/0, 1/1/1).
    pub fn getMapTile(self: *Self, allocator: std.mem.Allocator, input: get_map_tile.GetMapTileInput, options: get_map_tile.Options) !get_map_tile.GetMapTileOutput {
        return get_map_tile.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the [V2 `GetPlace`
    /// ](/location/latest/APIReference/API_geoplaces_GetPlace.html) operation
    /// unless you require Grab data.
    ///
    /// * This version of `GetPlace` is part of a previous Amazon Location Service
    ///   Places API (version 1) which has been superseded by a more intuitive,
    ///   powerful, and complete API (version 2).
    /// * Version 2 of the `GetPlace` operation interoperates with the rest of the
    ///   Places V2 API, while this version does not.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Places API version 2 is found under `geo-places` or
    ///   `geo_places`, not under `location`.
    /// * Since Grab is not yet fully supported in Places API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Places V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Places_V2.html) or the [Developer Guide](/location/latest/developerguide/places.html).
    ///
    /// Finds a place by its unique ID. A `PlaceId` is returned by other search
    /// operations.
    ///
    /// A PlaceId is valid only if all of the following are the same in the original
    /// search request and the call to `GetPlace`.
    ///
    /// * Customer Amazon Web Services account
    /// * Amazon Web Services Region
    /// * Data provider specified in the place index resource
    ///
    /// If your Place index resource is configured with Grab as your geolocation
    /// provider and Storage as Intended use, the GetPlace operation is unavailable.
    /// For more information, see [AWS service
    /// terms](http://aws.amazon.com/service-terms).
    pub fn getPlace(self: *Self, allocator: std.mem.Allocator, input: get_place.GetPlaceInput, options: get_place.Options) !get_place.GetPlaceOutput {
        return get_place.execute(self, allocator, input, options);
    }

    /// A batch request to retrieve all device positions.
    pub fn listDevicePositions(self: *Self, allocator: std.mem.Allocator, input: list_device_positions.ListDevicePositionsInput, options: list_device_positions.Options) !list_device_positions.ListDevicePositionsOutput {
        return list_device_positions.execute(self, allocator, input, options);
    }

    /// Lists geofence collections in your Amazon Web Services account.
    pub fn listGeofenceCollections(self: *Self, allocator: std.mem.Allocator, input: list_geofence_collections.ListGeofenceCollectionsInput, options: list_geofence_collections.Options) !list_geofence_collections.ListGeofenceCollectionsOutput {
        return list_geofence_collections.execute(self, allocator, input, options);
    }

    /// Lists geofences stored in a given geofence collection.
    pub fn listGeofences(self: *Self, allocator: std.mem.Allocator, input: list_geofences.ListGeofencesInput, options: list_geofences.Options) !list_geofences.ListGeofencesOutput {
        return list_geofences.execute(self, allocator, input, options);
    }

    /// Lists API key resources in your Amazon Web Services account.
    ///
    /// For more information, see [Use API keys to
    /// authenticate](https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html) in the *Amazon Location Service Developer Guide*.
    pub fn listKeys(self: *Self, allocator: std.mem.Allocator, input: list_keys.ListKeysInput, options: list_keys.Options) !list_keys.ListKeysOutput {
        return list_keys.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend upgrading to the Maps API V2 unless you require `Grab` data.
    ///
    /// * `ListMaps` is part of a previous Amazon Location Service Maps API (version
    ///   1) which has been superseded by a more intuitive, powerful, and complete
    ///   API (version 2).
    /// * The Maps API version 2 has a simplified interface that can be used without
    ///   creating or managing map resources.
    /// * If you are using an AWS SDK or the AWS CLI, note that the Maps API version
    ///   2 is found under `geo-maps` or `geo_maps`, not under `location`.
    /// * Since `Grab` is not yet fully supported in Maps API version 2, we
    ///   recommend you continue using API version 1 when using `Grab`.
    /// * Start your version 2 API journey with the [Maps V2 API
    ///   Reference](https://docs.aws.amazon.com/location/latest/APIReference/API_Operations_Amazon_Location_Service_Maps_V2.html) or the [Developer Guide](https://docs.aws.amazon.com/location/latest/developerguide/maps.html).
    ///
    /// Lists map resources in your Amazon Web Services account.
    pub fn listMaps(self: *Self, allocator: std.mem.Allocator, input: list_maps.ListMapsInput, options: list_maps.Options) !list_maps.ListMapsOutput {
        return list_maps.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the Places API V2 unless you require Grab data.
    ///
    /// * `ListPlaceIndexes` is part of a previous Amazon Location Service Places
    ///   API (version 1) which has been superseded by a more intuitive, powerful,
    ///   and complete API (version 2).
    /// * The Places API version 2 has a simplified interface that can be used
    ///   without creating or managing place index resources.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Places API version 2 is found under `geo-places` or
    ///   `geo_places`, not under `location`.
    /// * Since Grab is not yet fully supported in Places API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Places V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Places_V2.html) or the [Developer Guide](/location/latest/developerguide/places.html).
    ///
    /// Lists place index resources in your Amazon Web Services account.
    pub fn listPlaceIndexes(self: *Self, allocator: std.mem.Allocator, input: list_place_indexes.ListPlaceIndexesInput, options: list_place_indexes.Options) !list_place_indexes.ListPlaceIndexesOutput {
        return list_place_indexes.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the Routes API V2 unless you require Grab data.
    ///
    /// * `ListRouteCalculators` is part of a previous Amazon Location Service
    ///   Routes API (version 1) which has been superseded by a more intuitive,
    ///   powerful, and complete API (version 2).
    /// * The Routes API version 2 has a simplified interface that can be used
    ///   without creating or managing route calculator resources.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Routes API version 2 is found under `geo-routes` or
    ///   `geo_routes`, not under `location`.
    /// * Since Grab is not yet fully supported in Routes API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Routes V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Routes_V2.html) or the [Developer Guide](/location/latest/developerguide/routes.html).
    ///
    /// Lists route calculator resources in your Amazon Web Services account.
    pub fn listRouteCalculators(self: *Self, allocator: std.mem.Allocator, input: list_route_calculators.ListRouteCalculatorsInput, options: list_route_calculators.Options) !list_route_calculators.ListRouteCalculatorsOutput {
        return list_route_calculators.execute(self, allocator, input, options);
    }

    /// Returns a list of tags that are applied to the specified Amazon Location
    /// resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists geofence collections currently associated to the given tracker
    /// resource.
    pub fn listTrackerConsumers(self: *Self, allocator: std.mem.Allocator, input: list_tracker_consumers.ListTrackerConsumersInput, options: list_tracker_consumers.Options) !list_tracker_consumers.ListTrackerConsumersOutput {
        return list_tracker_consumers.execute(self, allocator, input, options);
    }

    /// Lists tracker resources in your Amazon Web Services account.
    pub fn listTrackers(self: *Self, allocator: std.mem.Allocator, input: list_trackers.ListTrackersInput, options: list_trackers.Options) !list_trackers.ListTrackersOutput {
        return list_trackers.execute(self, allocator, input, options);
    }

    /// Stores a geofence geometry in a given geofence collection, or updates the
    /// geometry of an existing geofence if a geofence ID is included in the
    /// request.
    pub fn putGeofence(self: *Self, allocator: std.mem.Allocator, input: put_geofence.PutGeofenceInput, options: put_geofence.Options) !put_geofence.PutGeofenceOutput {
        return put_geofence.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to [ `ReverseGeocode`
    /// ](/location/latest/APIReference/API_geoplaces_ReverseGeocode.html) or [
    /// `SearchNearby`
    /// ](/location/latest/APIReference/API_geoplaces_SearchNearby.html) unless you
    /// require Grab data.
    ///
    /// * `SearchPlaceIndexForPosition` is part of a previous Amazon Location
    ///   Service Places API (version 1) which has been superseded by a more
    ///   intuitive, powerful, and complete API (version 2).
    /// * The version 2 `ReverseGeocode` operation gives better results in the
    ///   address reverse-geocoding use case, while the version 2 `SearchNearby`
    ///   operation gives better results when searching for businesses and points of
    ///   interest near a specific location.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Places API version 2 is found under `geo-places` or
    ///   `geo_places`, not under `location`.
    /// * Since Grab is not yet fully supported in Places API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    ///
    /// Reverse geocodes a given coordinate and returns a legible address. Allows
    /// you to search for Places or points of interest near a given position.
    pub fn searchPlaceIndexForPosition(self: *Self, allocator: std.mem.Allocator, input: search_place_index_for_position.SearchPlaceIndexForPositionInput, options: search_place_index_for_position.Options) !search_place_index_for_position.SearchPlaceIndexForPositionOutput {
        return search_place_index_for_position.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to [ `Suggest`
    /// ](/location/latest/APIReference/API_geoplaces_Suggest.html) or [
    /// `Autocomplete`
    /// ](/location/latest/APIReference/API_geoplaces_Autocomplete.html) unless you
    /// require Grab data.
    ///
    /// * `SearchPlaceIndexForSuggestions` is part of a previous Amazon Location
    ///   Service Places API (version 1) which has been superseded by a more
    ///   intuitive, powerful, and complete API (version 2).
    /// * The version 2 `Suggest` operation gives better results for typeahead place
    ///   search suggestions with fuzzy matching, while the version 2 `Autocomplete`
    ///   operation gives better results for address completion based on partial
    ///   input.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Places API version 2 is found under `geo-places` or
    ///   `geo_places`, not under `location`.
    /// * Since Grab is not yet fully supported in Places API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    ///
    /// Generates suggestions for addresses and points of interest based on partial
    /// or misspelled free-form text. This operation is also known as autocomplete,
    /// autosuggest, or fuzzy matching.
    ///
    /// Optional parameters let you narrow your search results by bounding box or
    /// country, or bias your search toward a specific position on the globe.
    ///
    /// You can search for suggested place names near a specified position by using
    /// `BiasPosition`, or filter results within a bounding box by using
    /// `FilterBBox`. These parameters are mutually exclusive; using both
    /// `BiasPosition` and `FilterBBox` in the same command returns an error.
    pub fn searchPlaceIndexForSuggestions(self: *Self, allocator: std.mem.Allocator, input: search_place_index_for_suggestions.SearchPlaceIndexForSuggestionsInput, options: search_place_index_for_suggestions.Options) !search_place_index_for_suggestions.SearchPlaceIndexForSuggestionsOutput {
        return search_place_index_for_suggestions.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to [ `Geocode`
    /// ](/location/latest/APIReference/API_geoplaces_Geocode.html) or [
    /// `SearchText` ](/location/latest/APIReference/API_geoplaces_SearchText.html)
    /// unless you require Grab data.
    ///
    /// * `SearchPlaceIndexForText` is part of a previous Amazon Location Service
    ///   Places API (version 1) which has been superseded by a more intuitive,
    ///   powerful, and complete API (version 2).
    /// * The version 2 `Geocode` operation gives better results in the address
    ///   geocoding use case, while the version 2 `SearchText` operation gives
    ///   better results when searching for businesses and points of interest.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Places API version 2 is found under `geo-places` or
    ///   `geo_places`, not under `location`.
    /// * Since Grab is not yet fully supported in Places API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    ///
    /// Geocodes free-form text, such as an address, name, city, or region to allow
    /// you to search for Places or points of interest.
    ///
    /// Optional parameters let you narrow your search results by bounding box or
    /// country, or bias your search toward a specific position on the globe.
    ///
    /// You can search for places near a given position using `BiasPosition`, or
    /// filter results within a bounding box using `FilterBBox`. Providing both
    /// parameters simultaneously returns an error.
    ///
    /// Search results are returned in order of highest to lowest relevance.
    pub fn searchPlaceIndexForText(self: *Self, allocator: std.mem.Allocator, input: search_place_index_for_text.SearchPlaceIndexForTextInput, options: search_place_index_for_text.Options) !search_place_index_for_text.SearchPlaceIndexForTextOutput {
        return search_place_index_for_text.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified Amazon Location
    /// Service resource.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to scope user permissions, by granting a user permission to access or
    /// change only resources with certain tag values.
    ///
    /// You can use the `TagResource` operation with an Amazon Location Service
    /// resource that already has tags. If you specify a new tag key for the
    /// resource, this tag is appended to the tags already associated with the
    /// resource. If you specify a tag key that's already associated with the
    /// resource, the new tag value that you specify replaces the previous value for
    /// that tag.
    ///
    /// You can associate up to 50 tags with a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified Amazon Location resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified properties of a given geofence collection.
    pub fn updateGeofenceCollection(self: *Self, allocator: std.mem.Allocator, input: update_geofence_collection.UpdateGeofenceCollectionInput, options: update_geofence_collection.Options) !update_geofence_collection.UpdateGeofenceCollectionOutput {
        return update_geofence_collection.execute(self, allocator, input, options);
    }

    /// Updates the specified properties of a given API key resource.
    pub fn updateKey(self: *Self, allocator: std.mem.Allocator, input: update_key.UpdateKeyInput, options: update_key.Options) !update_key.UpdateKeyOutput {
        return update_key.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend upgrading to the Maps API V2 unless you require `Grab` data.
    ///
    /// * `UpdateMap` is part of a previous Amazon Location Service Maps API
    ///   (version 1) which has been superseded by a more intuitive, powerful, and
    ///   complete API (version 2).
    /// * The Maps API version 2 has a simplified interface that can be used without
    ///   creating or managing map resources.
    /// * If you are using an AWS SDK or the AWS CLI, note that the Maps API version
    ///   2 is found under `geo-maps` or `geo_maps`, not under `location`.
    /// * Since `Grab` is not yet fully supported in Maps API version 2, we
    ///   recommend you continue using API version 1 when using `Grab`.
    /// * Start your version 2 API journey with the [Maps V2 API
    ///   Reference](https://docs.aws.amazon.com/location/latest/APIReference/API_Operations_Amazon_Location_Service_Maps_V2.html) or the [Developer Guide](https://docs.aws.amazon.com/location/latest/developerguide/maps.html).
    ///
    /// Updates the specified properties of a given map resource.
    pub fn updateMap(self: *Self, allocator: std.mem.Allocator, input: update_map.UpdateMapInput, options: update_map.Options) !update_map.UpdateMapOutput {
        return update_map.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the Places API V2 unless you require Grab data.
    ///
    /// * `UpdatePlaceIndex` is part of a previous Amazon Location Service Places
    ///   API (version 1) which has been superseded by a more intuitive, powerful,
    ///   and complete API (version 2).
    /// * The Places API version 2 has a simplified interface that can be used
    ///   without creating or managing place index resources.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Places API version 2 is found under `geo-places` or
    ///   `geo_places`, not under `location`.
    /// * Since Grab is not yet fully supported in Places API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Places V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Places_V2.html) or the [Developer Guide](/location/latest/developerguide/places.html).
    ///
    /// Updates the specified properties of a given place index resource.
    pub fn updatePlaceIndex(self: *Self, allocator: std.mem.Allocator, input: update_place_index.UpdatePlaceIndexInput, options: update_place_index.Options) !update_place_index.UpdatePlaceIndexOutput {
        return update_place_index.execute(self, allocator, input, options);
    }

    /// This operation is no longer current and may be deprecated in the future. We
    /// recommend you upgrade to the Routes API V2 unless you require Grab data.
    ///
    /// * `UpdateRouteCalculator` is part of a previous Amazon Location Service
    ///   Routes API (version 1) which has been superseded by a more intuitive,
    ///   powerful, and complete API (version 2).
    /// * The Routes API version 2 has a simplified interface that can be used
    ///   without creating or managing route calculator resources.
    /// * If you are using an Amazon Web Services SDK or the Amazon Web Services
    ///   CLI, note that the Routes API version 2 is found under `geo-routes` or
    ///   `geo_routes`, not under `location`.
    /// * Since Grab is not yet fully supported in Routes API version 2, we
    ///   recommend you continue using API version 1 when using Grab.
    /// * Start your version 2 API journey with the Routes V2 [API
    ///   Reference](/location/latest/APIReference/API_Operations_Amazon_Location_Service_Routes_V2.html) or the [Developer Guide](/location/latest/developerguide/routes.html).
    ///
    /// Updates the specified properties for a given route calculator resource.
    pub fn updateRouteCalculator(self: *Self, allocator: std.mem.Allocator, input: update_route_calculator.UpdateRouteCalculatorInput, options: update_route_calculator.Options) !update_route_calculator.UpdateRouteCalculatorOutput {
        return update_route_calculator.execute(self, allocator, input, options);
    }

    /// Updates the specified properties of a given tracker resource.
    pub fn updateTracker(self: *Self, allocator: std.mem.Allocator, input: update_tracker.UpdateTrackerInput, options: update_tracker.Options) !update_tracker.UpdateTrackerOutput {
        return update_tracker.execute(self, allocator, input, options);
    }

    /// Verifies the integrity of the device's position by determining if it was
    /// reported behind a proxy, and by comparing it to an inferred position
    /// estimated based on the device's state.
    ///
    /// The Location Integrity SDK provides enhanced features related to device
    /// verification, and it is available for use by request. To get access to the
    /// SDK, contact [Sales
    /// Support](https://aws.amazon.com/contact-us/sales-support/?pg=locationprice&cta=herobtn).
    pub fn verifyDevicePosition(self: *Self, allocator: std.mem.Allocator, input: verify_device_position.VerifyDevicePositionInput, options: verify_device_position.Options) !verify_device_position.VerifyDevicePositionOutput {
        return verify_device_position.execute(self, allocator, input, options);
    }

    pub fn forecastGeofenceEventsPaginator(self: *Self, params: forecast_geofence_events.ForecastGeofenceEventsInput) paginator.ForecastGeofenceEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getDevicePositionHistoryPaginator(self: *Self, params: get_device_position_history.GetDevicePositionHistoryInput) paginator.GetDevicePositionHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDevicePositionsPaginator(self: *Self, params: list_device_positions.ListDevicePositionsInput) paginator.ListDevicePositionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGeofenceCollectionsPaginator(self: *Self, params: list_geofence_collections.ListGeofenceCollectionsInput) paginator.ListGeofenceCollectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGeofencesPaginator(self: *Self, params: list_geofences.ListGeofencesInput) paginator.ListGeofencesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listKeysPaginator(self: *Self, params: list_keys.ListKeysInput) paginator.ListKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMapsPaginator(self: *Self, params: list_maps.ListMapsInput) paginator.ListMapsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPlaceIndexesPaginator(self: *Self, params: list_place_indexes.ListPlaceIndexesInput) paginator.ListPlaceIndexesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRouteCalculatorsPaginator(self: *Self, params: list_route_calculators.ListRouteCalculatorsInput) paginator.ListRouteCalculatorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrackerConsumersPaginator(self: *Self, params: list_tracker_consumers.ListTrackerConsumersInput) paginator.ListTrackerConsumersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrackersPaginator(self: *Self, params: list_trackers.ListTrackersInput) paginator.ListTrackersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
