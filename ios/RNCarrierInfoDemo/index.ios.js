/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  AlertIOS,
  TouchableOpacity,
} = React;

var CarrierInfo = require('NativeModules').RNCarrierInfo;

var RNCarrierInfoDemo = React.createClass({

  getAllowsVOIP: function() {
    CarrierInfo.allowsVOIP(
      (result) => AlertIOS.alert('VoIP', JSON.stringify(result))
    );
  },
  getCarrierName: function() {
    CarrierInfo.carrierName(
      (result) => AlertIOS.alert('Carrier Name', result)
    );
  },
  getIsoCountryCode: function() {
    CarrierInfo.isoCountryCode(
      (result) => AlertIOS.alert('ISO Code', result)
    );
  },
  getMobileCountryCode: function() {
    CarrierInfo.mobileCountryCode(
      (result) => AlertIOS.alert('MCC Code', result)
    );
  },
  getMobileNetworkCode: function() {
    CarrierInfo.mobileNetworkCode(
      (result) => AlertIOS.alert('MNC Code', result)
    );
  },

  render: function() {
    return (
      <View style={styles.container}>
        <Text style={styles.instruction}>Clicking on each question will show a UIAlert with the callback response</Text>
        <TouchableOpacity onPress={this.getAllowsVOIP}>
          <Text style={styles.question}>Does my carrier support VoIP calls?</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={this.getCarrierName}>
          <Text style={styles.question}>What is my carrier's name?</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={this.getIsoCountryCode}>
          <Text style={styles.question}>What is my carrier's iso country code?</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={this.getMobileCountryCode}>
          <Text style={styles.question}>What is my carrier's mobile country code?</Text>
        </TouchableOpacity>
        <TouchableOpacity onPress={this.getMobileNetworkCode}>
          <Text style={styles.question}>What is my carrier's mobile network code?</Text>
        </TouchableOpacity>
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    backgroundColor: 'rgb(253,253,253)',
  },
  instruction: {
    fontSize: 20,
    fontWeight: 'bold',
    margin: 10,
    color: 'rgba(0,0,0,0.75)',
  },
  question: {
    fontSize: 20,
    margin: 10,
    color: 'rgba(0,0,0,0.54)',
  },
});

AppRegistry.registerComponent('RNCarrierInfoDemo', () => RNCarrierInfoDemo);
