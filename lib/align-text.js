'use babel';

import { CompositeDisposable } from 'atom';
import { align } from './align'

export default {

  modalPanel: null,
  subscriptions: null,

  activate(state) {
    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'align-text:align': () => this.align()
    }));
  },

  deactivate() {
    this.subscriptions.dispose();
  },

  serialize() {
    return {};
  },

  align() {
    console.log('Align!');
    return align();
  }

};
