<template>
  <div>
    <div class="status">
      Status: <span id="status">Loading...</span> <br>
      <router-link to="/">Go to personal info page</router-link>
    </div>
    <div class="create mt">
      <span class="headerName mb">Create Patent:</span>
      <div>
        <div>
        <input v-model="inventor" type="text" placeholder="inventor">
        </div>
        <div>
        <input v-model="applicantsName" type="text" placeholder="applicantsname">
        </div>
        <div>
        <input v-model="agentName" type="text" placeholder="agentname">
        </div>
        <div>
        <input v-model="state" type="text" placeholder="state">
        </div>
        <div>
        <input v-model="registrationAddress" type="text" placeholder="registrationaddress">
        </div>
        <div>
        <input v-model="title" type="text" placeholder="title">
        </div>
        <div>
        <input v-model="link" type="text" placeholder="link">
        </div>
        <div>
        <input v-model="country" type="text" placeholder="country">
        </div>
        <div>
        <button @click="createPatent">Create!</button>
        </div>
      </div>
    </div>   
    <div class="transfer mt">
      <span class="headerName">Ownership Transfer:</span>
      <div>
        <input v-model="uidd" type="text" placeholder="enter the uid of patent">
        <input v-model="transfee" type="text" placeholder="enter the account to transfer">
        <button @click="transferOwnership">Transfer!</button>
      </div>
    </div>
    <div class="patents mt">
      <span class="headerName">Patents:</span>
      <div>
        {{patentsinfo}}
      </div>
      <button @click="getPatents">Get!</button>
    </div>
  </div>
</template>

<script>
import Web3 from 'web3';

async function loadWeb3() {
    if (window.ethereum) {
        window.web3 = new Web3(window.ethereum);
        window.ethereum.enable();
    }
}
async function load() {
    await loadWeb3();
    window.contract = await loadContract();
    updateStatus('Ready!');
}

function updateStatus(status) {
    const statusEl = document.getElementById('status');
    statusEl.innerHTML = status;
    console.log(status);
}

async function getCurrentAccount() {
    const accounts = await window.web3.eth.getAccounts();
    return accounts[0];
}

const ABI = [
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "uid",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "address",
				"name": "by",
				"type": "address"
			}
		],
		"name": "CreatePatent",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "uid",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "address",
				"name": "by",
				"type": "address"
			}
		],
		"name": "UpdatePatent",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_owner",
				"type": "address"
			},
			{
				"internalType": "string",
				"name": "_inventor",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_applicantsName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_agentName",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_state",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_registrationAddress",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_title",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_link",
				"type": "string"
			},
			{
				"internalType": "string",
				"name": "_country",
				"type": "string"
			}
		],
		"name": "createPatent",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "uid",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "uid",
				"type": "uint256"
			}
		],
		"name": "getPatent",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "uid",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "owner",
						"type": "address"
					},
					{
						"internalType": "string",
						"name": "applicantsName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "inventor",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "agentName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "state",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "registrationAddress",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "title",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "link",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "country",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "patentNumber",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "decisionNumber",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "decisionDate",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "lawNumber",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "internationalClassificationNumber",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "responsiblePerson",
						"type": "string"
					}
				],
				"internalType": "struct Patenter.Patent",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getPatents",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "uid",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "owner",
						"type": "address"
					},
					{
						"internalType": "string",
						"name": "applicantsName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "inventor",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "agentName",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "state",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "registrationAddress",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "title",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "link",
						"type": "string"
					},
					{
						"internalType": "string",
						"name": "country",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "patentNumber",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "decisionNumber",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "decisionDate",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "lawNumber",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "internationalClassificationNumber",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "responsiblePerson",
						"type": "string"
					}
				],
				"internalType": "struct Patenter.Patent[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"name": "patentUids",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "uid",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];

const contractAddress = '0x30e8D7575ABA2088DB6CEF5cC26Db5cFCBbe673a';

async function loadContract() {
    return await new window.web3.eth.Contract(ABI, contractAddress);
}

load();

export default {
  name: "Home",
  components: {},
  data() {
    return {
      uidd: '',
      patentsinfo: [],
      owner: '',
      applicantsName: '',
      inventor: '',
      agentName: '',
      state: '',
      registrationAddress: '',
      title: '',
      link: '',
      country: '',
      patentNumber: '',
      decisionNumber: '',
      decisionDate: '',
      lawNumber: '',
      internationalCassificationNumber: '',
      responsiblePerson: '',
      transfee: '',
    };
  },
  methods: {
    async createPatent() {
      updateStatus('creating a patent...');
      const account = await getCurrentAccount();
      const patentCreation = await window.contract.methods.createPatent(account, this.inventor, this.applicantsName, this.agentName, this.state, this.registrationAddress, this.title, this.link, this.country).send({ from: account });
      console.log('created:', patentCreation);
      updateStatus('created a patent');
      updateStatus(patentCreation);
    },
    async getPatents() {
      updateStatus('getting patents...');
      const patentsRetrieval = await window.contract.methods.getPatents().call();
      console.log('received:', patentsRetrieval);
      this.patentsinfo = patentsRetrieval;
      updateStatus('received patents');
    },
    async transferOwnership() {
      const newStatus = 'ownership has been transferred to ' + this.transfee;
      updateStatus('tranferring ownership to:');
      const account = await getCurrentAccount();
      const ownershipTransfer = await window.contract.methods.transferOwnership(this.uidd, this.transfee).send({ from: account });
      console.log('transferred:', ownershipTransfer);
      updateStatus(newStatus);
    },
  }
}
</script>
