const aws = @import("aws");
const std = @import("std");

const autocomplete_ = @import("autocomplete.zig");
const geocode_ = @import("geocode.zig");
const get_place = @import("get_place.zig");
const reverse_geocode = @import("reverse_geocode.zig");
const search_nearby = @import("search_nearby.zig");
const search_text = @import("search_text.zig");
const suggest_ = @import("suggest.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Geo Places";

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

    /// `Autocomplete` completes potential places and addresses as the user types,
    /// based on the partial input. The API enhances the efficiency and accuracy of
    /// address by completing query based on a few entered keystrokes. It helps you
    /// by completing partial queries with valid address completion. Also, the API
    /// supports the filtering of results based on geographic location, country, or
    /// specific place types, and can be tailored using optional parameters like
    /// language and political views.
    ///
    /// For more information, see
    /// [Autocomplete](https://docs.aws.amazon.com/location/latest/developerguide/autocomplete.html) in the *Amazon Location Service Developer Guide*.
    pub fn autocomplete(self: *Self, allocator: std.mem.Allocator, input: autocomplete_.AutocompleteInput, options: autocomplete_.Options) !autocomplete_.AutocompleteOutput {
        return autocomplete_.execute(self, allocator, input, options);
    }

    /// `Geocode` converts a textual address or place into geographic coordinates.
    /// You can obtain geographic coordinates, address component, and other related
    /// information. It supports flexible queries, including free-form text or
    /// structured queries with components like street names, postal codes, and
    /// regions. The Geocode API can also provide additional features such as time
    /// zone information and the inclusion of political views.
    ///
    /// For more information, see
    /// [Geocode](https://docs.aws.amazon.com/location/latest/developerguide/geocode.html) in the *Amazon Location Service Developer Guide*.
    pub fn geocode(self: *Self, allocator: std.mem.Allocator, input: geocode_.GeocodeInput, options: geocode_.Options) !geocode_.GeocodeOutput {
        return geocode_.execute(self, allocator, input, options);
    }

    /// `GetPlace` finds a place by its unique ID. A `PlaceId` is returned by other
    /// place operations.
    ///
    /// For more information, see
    /// [GetPlace](https://docs.aws.amazon.com/location/latest/developerguide/get-place.html) in the *Amazon Location Service Developer Guide*.
    pub fn getPlace(self: *Self, allocator: std.mem.Allocator, input: get_place.GetPlaceInput, options: get_place.Options) !get_place.GetPlaceOutput {
        return get_place.execute(self, allocator, input, options);
    }

    /// `ReverseGeocode` converts geographic coordinates into a human-readable
    /// address or place. You can obtain address component, and other related
    /// information such as place type, category, street information. The Reverse
    /// Geocode API supports filtering to on place type so that you can refine
    /// result based on your need. Also, The Reverse Geocode API can also provide
    /// additional features such as time zone information and the inclusion of
    /// political views.
    ///
    /// For more information, see [Reverse
    /// Geocode](https://docs.aws.amazon.com/location/latest/developerguide/reverse-geocode.html) in the *Amazon Location Service Developer Guide*.
    pub fn reverseGeocode(self: *Self, allocator: std.mem.Allocator, input: reverse_geocode.ReverseGeocodeInput, options: reverse_geocode.Options) !reverse_geocode.ReverseGeocodeOutput {
        return reverse_geocode.execute(self, allocator, input, options);
    }

    /// `SearchNearby` queries for points of interest within a radius from a central
    /// coordinates, returning place results with optional filters such as
    /// categories, business chains, food types and more. The API returns details
    /// such as a place name, address, phone, category, food type, contact, opening
    /// hours. Also, the API can return phonemes, time zones and more based on
    /// requested parameters.
    ///
    /// For more information, see [Search
    /// Nearby](https://docs.aws.amazon.com/location/latest/developerguide/search-nearby.html) in the *Amazon Location Service Developer Guide*.
    pub fn searchNearby(self: *Self, allocator: std.mem.Allocator, input: search_nearby.SearchNearbyInput, options: search_nearby.Options) !search_nearby.SearchNearbyOutput {
        return search_nearby.execute(self, allocator, input, options);
    }

    /// `SearchText` searches for geocode and place information. You can then
    /// complete a follow-up query suggested from the `Suggest` API via a query id.
    ///
    /// For more information, see [Search
    /// Text](https://docs.aws.amazon.com/location/latest/developerguide/search-text.html) in the *Amazon Location Service Developer Guide*.
    pub fn searchText(self: *Self, allocator: std.mem.Allocator, input: search_text.SearchTextInput, options: search_text.Options) !search_text.SearchTextOutput {
        return search_text.execute(self, allocator, input, options);
    }

    /// `Suggest` provides intelligent predictions or recommendations based on the
    /// user's input or context, such as relevant places, points of interest, query
    /// terms or search category. It is designed to help users find places or point
    /// of interests candidates or identify a follow on query based on incomplete or
    /// misspelled queries. It returns a list of possible matches or refinements
    /// that can be used to formulate a more accurate query. Users can select the
    /// most appropriate suggestion and use it for further searching. The API
    /// provides options for filtering results by location and other attributes, and
    /// allows for additional features like phonemes and timezones. The response
    /// includes refined query terms and detailed place information.
    ///
    /// For more information, see
    /// [Suggest](https://docs.aws.amazon.com/location/latest/developerguide/suggest.html) in the *Amazon Location Service Developer Guide*.
    pub fn suggest(self: *Self, allocator: std.mem.Allocator, input: suggest_.SuggestInput, options: suggest_.Options) !suggest_.SuggestOutput {
        return suggest_.execute(self, allocator, input, options);
    }
};
