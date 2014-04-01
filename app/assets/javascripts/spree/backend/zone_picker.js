$.fn.zoneAutocomplete = function () {
  'use strict';

  this.select2({
    minimumInputLength: 1,
    multiple: true,
    initSelection: function (element, callback) {
      $.get(Spree.routes.zone_search, {
        ids: element.val().split(',')
      }, function (data) {
        callback(data.zones);
      });
    },
    ajax: {
      url: Spree.routes.zone_search,
      datatype: 'json',
      data: function (term, page) {
        return {
          q: {
            name_cont: term
          },
          m: 'OR',
          token: Spree.api_key
        };
      },
      results: function (data, page) {
        var zones = data.zones ? data.zones : [];
        return {
          results: zones
        };
      }
    },
    formatResult: function (zone) {
      return zone.name;
    },
    formatSelection: function (zone) {
      return zone.name;
    }
  });
};

$(document).ready(function () {
  $('.zone_picker').zoneAutocomplete();
});
